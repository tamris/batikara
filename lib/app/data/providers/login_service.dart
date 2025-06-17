import 'package:dio/dio.dart';
import 'package:sibatikgal/app/data/config/app_config.dart';

import '../utils/device_utils.dart';

class LoginService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: AppConfig.baseUrl, // Ganti dengan IP atau domain Flask kamu
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
  ));

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final deviceName = await getDeviceInfo();
      final response = await _dio.post(
        '/login',
        data: {
          'email': email,
          'password': password,
          'device_name': deviceName, // Kirim ke backend
        },
      );

      return {
        'success': true,
        'data': response.data,
      };
    } on DioException catch (e) {
      final errorMessage = e.response?.data['msg'] ?? 'Tidak terhubung ke server';
      return {
        'success': false,
        'message': errorMessage,
      };
    }
  }
}
