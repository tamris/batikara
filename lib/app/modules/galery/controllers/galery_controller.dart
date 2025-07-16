import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import '../../../data/config/app_config.dart';
import '../../../data/models/gallery_model.dart';
import '../../../data/providers/gallery_service.dart';

class GalleryController extends GetxController {
  final GalleryService _service = GalleryService();
  final box = GetStorage();

  var allItems = <GalleryModel>[].obs;
  var visibleItems = <GalleryModel>[].obs;
  var isLoading = true.obs;
  var isFetchingMore = false.obs;

  final ScrollController scrollController = ScrollController();
  final int itemsPerPage = 10;
  int currentIndex = 0;

  @override
  void onInit() {
    super.onInit();
    loadGalleryWithFavorites();
    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100 &&
        !isFetchingMore.value &&
        visibleItems.length < allItems.length) {
      loadMoreItems();
    }
  }

  Future<void> loadGalleryWithFavorites() async {
    final token = box.read('token');

    try {
      isLoading(true);
      final all = await _service.fetchGallery();

      final favResponse = await Dio().get(
        '${AppConfig.baseUrl}/favorites',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      final List<String> favIds =
          (favResponse.data as List).map((e) => e['id'].toString()).toList();

      for (var item in all) {
        item.isFavorite = favIds.contains(item.id);
      }

      allItems.assignAll(all);
      visibleItems.clear();
      currentIndex = 0;
      loadMoreItems();
    } catch (e) {
      print('Error loading gallery or favorites: $e');
    } finally {
      isLoading(false);
    }
  }

  void loadMoreItems() {
    isFetchingMore(true);
    final nextItems = allItems.skip(currentIndex).take(itemsPerPage).toList();
    visibleItems.addAll(nextItems);
    currentIndex += nextItems.length;
    isFetchingMore(false);
  }

  void toggleFavoriteWithUser(GalleryModel item) async {
    final token = box.read('token');

    try {
      final response = await Dio().post(
        '${AppConfig.baseUrl}/favorites/toggle',
        data: {'gallery_id': item.id},
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        item.isFavorite = !item.isFavorite;
        visibleItems.refresh();
      }
    } catch (e) {
      print('Toggle favorite error: $e');
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      visibleItems.clear();
      currentIndex = 0;
      loadMoreItems();
    } else {
      final filtered = allItems
          .where((item) =>
              item.namaBatik.toLowerCase().contains(query.toLowerCase()))
          .toList();
      visibleItems.assignAll(filtered);
      currentIndex = filtered.length;
    }
  }
}
