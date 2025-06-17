import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/config/app_config.dart';
import '../../../data/models/gallery_model.dart';


class FavoritController extends GetxController {
  final box = GetStorage();
  final favorites = <GalleryModel>[].obs;
  final filteredItems = <GalleryModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFavorites();
  }

  void search(String query) {
    if (query.isEmpty) {
      filteredItems.assignAll(favorites);
    } else {
      filteredItems.assignAll(
        favorites.where((item) =>
            item.namaBatik.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }

  Future<void> fetchFavorites() async {
    final token = box.read('token');
    try {
      isLoading(true);
      final response = await Dio().get(
        '${AppConfig.baseUrl}/favorites',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final data = (response.data as List)
          .map((e) => GalleryModel.fromJson(e)..isFavorite = true)
          .toList();

      favorites.assignAll(data);
      filteredItems.assignAll(data);
    } catch (e) {
      print('Error fetching favorites: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> toggleFavorite(GalleryModel item) async {
    final token = box.read('token');

    try {
      final response = await Dio().post(
        '${AppConfig.baseUrl}/favorites/toggle',
        data: {"gallery_id": item.id},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        item.isFavorite = false;
        favorites.removeWhere((e) => e.id == item.id);
        search(""); // refresh view
      }
    } catch (e) {
      print('Toggle favorite failed: $e');
    }
  }
}
