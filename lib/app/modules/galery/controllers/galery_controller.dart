import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/config/app_config.dart';
import '../../../data/models/gallery_model.dart';
import '../../../data/providers/gallery_service.dart';

class GalleryController extends GetxController {
  final GalleryService _service = GalleryService();
  final box = GetStorage();

  var allItems = <GalleryModel>[].obs;
  var filteredItems = <GalleryModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadGalleryWithFavorites();
  }

  void search(String query) {
    if (query.isEmpty) {
      filteredItems.assignAll(allItems);
    } else {
      filteredItems.assignAll(
        allItems.where((item) =>
            item.namaBatik.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }

  Future<void> loadGalleryWithFavorites() async {
    final token = box.read('token');

    try {
      isLoading(true);

      final all = await _service.fetchGallery();

      final favResponse = await Dio().get(
        '${AppConfig.baseUrl}/favorites',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final List<String> favIds = (favResponse.data as List)
          .map((e) => e['id'].toString())
          .toList();

      for (var item in all) {
        item.isFavorite = favIds.contains(item.id);
      }

      allItems.assignAll(all);
      filteredItems.assignAll(all);
    } catch (e) {
      print('Error loading gallery or favorites: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> toggleFavoriteWithUser(GalleryModel item) async {
    final token = box.read('token');

    try {
      final response = await Dio().post(
        '${AppConfig.baseUrl}/favorites/toggle',
        data: {
          'gallery_id': item.id,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        item.isFavorite = !item.isFavorite;
        filteredItems.refresh();
      }
    } catch (e) {
      print('Toggle favorite error: $e');
    }
  }
}
