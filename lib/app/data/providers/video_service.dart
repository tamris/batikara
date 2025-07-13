import 'package:dio/dio.dart';
import '../config/app_config.dart';
import '../models/video_model.dart';

class VideoService {
  static final Dio _dio = Dio();

  static Future<List<VideoModel>> fetchVideos() async {
    try {
      final response = await _dio.get('${AppConfig.baseUrl}/videos/api');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => VideoModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data video');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
