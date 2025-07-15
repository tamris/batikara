import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../config/app_config.dart';

class DeteksiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  static Future<Map<String, dynamic>> deteksiBatik(File imageFile) async {
    final fileName = imageFile.path.split('/').last;

    final storage = GetStorage();
    final token = storage.read('token'); // Ambil token dari GetStorage

    if (token == null) {
      return {
        'success': false,
        'error': 'Token tidak ditemukan. Silakan login ulang.',
      };
    }

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imageFile.path, filename: fileName),
    });

    try {
      final response = await _dio.post(
        '/predict',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // ← header penting!
          },
        ),
      );
      return response.data;
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }
}
