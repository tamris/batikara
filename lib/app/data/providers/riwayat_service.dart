import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../config/app_config.dart';

class RiwayatService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  static Future<List<Map<String, dynamic>>> getRiwayat() async {
    final token = GetStorage().read('token');

    if (token == null) {
      throw Exception('Token tidak ditemukan. Silakan login ulang.');
    }

    try {
      final response = await _dio.get(
        '/riwayat',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.data['success'] == true) {
        return List<Map<String, dynamic>>.from(response.data['data']);
      } else {
        throw Exception(response.data['error'] ?? 'Gagal memuat riwayat');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getDetectionStats() async {
    final token = GetStorage().read('token');

    if (token == null) {
      throw Exception('Token tidak ditemukan. Silakan login ulang.');
    }

    try {
      final response = await _dio.get(
        '/detection/stats',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.data['success']) {
        return List<Map<String, dynamic>>.from(response.data['data']);
      }
    } catch (e) {
      print("❌ Gagal ambil statistik: $e");
    }
    return [];
  }
}
