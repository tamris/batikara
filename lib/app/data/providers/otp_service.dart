// lib/services/otp_service.dart
import 'package:dio/dio.dart';

import '../config/app_config.dart';

class OtpService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: AppConfig.baseUrl, // ganti sesuai IP/backend kamu
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
  ));

  Future<Map<String, dynamic>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _dio.post(
        '/verify-otp',
        data: {
          'email': email,
          'otp': otp,
        },
      );

      return {
        'success': true,
        'message': response.data['msg'],
      };
    } on DioException catch (e) {
      final msg = e.response?.data['msg'] ?? 'Verifikasi OTP gagal';
      return {
        'success': false,
        'message': msg,
      };
    }
  }

  Future<Map<String, dynamic>> resendOtp({required String email}) async {
    try {
      final response = await _dio.post(
        '/resend-otp',
        data: {
          'email': email,
        },
      );

      return {
        'success': true,
        'message': response.data['msg'],
      };
    } on DioException catch (e) {
      final msg = e.response?.data['msg'] ?? 'Gagal mengirim ulang OTP';
      return {
        'success': false,
        'message': msg,
      };
    }
  }
}
