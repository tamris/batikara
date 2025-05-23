// lib/services/register_service.dart
import 'package:dio/dio.dart';

import '../config/app_config.dart';

class RegisterService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: AppConfig.baseUrl, // ganti sesuai host backend kamu
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
  ));

  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/register',
        data: {
          'username': username,
          'email': email,
          'password': password,
        },
      );

      return {
        'success': true,
        'message': response.data['msg'],
      };
    } on DioException catch (e) {
      final msg = e.response?.data['msg'] ?? 'Registrasi gagal';
      return {
        'success': false,
        'message': msg,
      };
    }
  }
}
