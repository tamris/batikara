import 'package:dio/dio.dart';
import '../config/app_config.dart';
import '../models/gallery_model.dart'; // Pastikan path ini sesuai

class GalleryService {
  final Dio _dio = Dio();

  Future<List<GalleryModel>> fetchGallery() async {
    try {
      final response = await _dio.get('${AppConfig.baseUrl}/gallery');

      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((json) => GalleryModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal mengambil data galeri');
      }
    } catch (e) {
      print('GalleryService Error: $e');
      rethrow;
    }
  }
}
