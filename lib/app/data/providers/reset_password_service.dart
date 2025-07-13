import 'package:dio/dio.dart';
import '../config/app_config.dart';

class ResetPasswordService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: AppConfig.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<Map<String, dynamic>> sendResetOtp(String email) async {
    try {
      final res = await _dio.post('/reset/request', data: {'email': email});
      print('🟢 [sendResetOtp] Response: ${res.data}');
      return {
        'success': true,
        'message': res.data['msg'] ?? 'Berhasil kirim OTP',
      };
    } on DioException catch (e) {
      print('🔴 [sendResetOtp] Error: ${e.response?.data}');
      final msg = e.response?.data['msg'] ?? 'Gagal mengirim OTP';
      return {'success': false, 'message': msg};
    }
  }

  Future<Map<String, dynamic>> verifyResetOtp(String email, String otp) async {
    try {
      final res = await _dio.post('/reset/verify', data: {
        'email': email,
        'otp': otp,
      });
      print('🟢 [verifyResetOtp] Response: ${res.data}');
      return {'success': true, 'message': res.data['msg']};
    } on DioException catch (e) {
      print('🔴 [verifyResetOtp] Error: ${e.response?.data}');
      final msg = e.response?.data['msg'] ?? 'Verifikasi OTP gagal';
      return {'success': false, 'message': msg};
    }
  }

  Future<Map<String, dynamic>> confirmNewPassword({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _dio.post('/reset/confirm', data: {
        'email': email,
        'password': password,
      });
      print('🟢 [confirmNewPassword] Response: ${res.data}');
      return {'success': true, 'message': res.data['msg']};
    } on DioException catch (e) {
      print('🔴 [confirmNewPassword] Error: ${e.response?.data}');
      final msg = e.response?.data['msg'] ?? 'Gagal mengganti password';
      return {'success': false, 'message': msg};
    }
  }
}
