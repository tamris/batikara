import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../config/app_config.dart';

class UserService {
  final _storage = GetStorage();
  final Dio _dio = Dio();

  // Ambil profil
  Future<Map<String, dynamic>?> fetchProfile() async {
    final token = _storage.read('token');
    if (token == null) return null;

    try {
      final response = await _dio.get(
        '${AppConfig.baseUrl}/user/profile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response.data;
    } on DioException catch (e) {
      print('❌ Dio error: ${e.response?.statusCode} - ${e.response?.data}');
      return null;
    } catch (e) {
      print('❌ Unexpected error: $e');
      return null;
    }
  }

  // Update profil (form-data + upload file)
  Future<bool> updateProfile({
    required String username,
    required String gender,
    required String tanggalLahir,
    File? profilePicture,
  }) async {
    final token = _storage.read('token');
    if (token == null) return false;

    try {
      final formData = FormData.fromMap({
        'username': username,
        'gender': gender,
        'tanggal_lahir': tanggalLahir,
        if (profilePicture != null)
          'profile_picture': await MultipartFile.fromFile(
            profilePicture.path,
            filename: profilePicture.path.split('/').last,
          ),
      });

      final response = await _dio.put(
        '${AppConfig.baseUrl}/user/profile/edit',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("❌ Error update profile: $e");
      return false;
    }
  }

  // Ganti password
  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final token = _storage.read('token');
    if (token == null) {
      return {
        'success': false,
        'message': 'Token tidak ditemukan. Harap login ulang.',
      };
    }

    try {
      final response = await _dio.post(
        '${AppConfig.baseUrl}/user/profile/change-password',
        data: {
          'current_password': currentPassword,
          'new_password': newPassword,
          'confirm_password': confirmPassword,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      return {
        'success': true,
        'message': response.data['message'] ?? 'Password berhasil diubah',
      };
    } on DioException catch (e) {
      final msg = e.response?.data['message'] ?? 'Terjadi kesalahan';
      return {
        'success': false,
        'message': msg,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Kesalahan tidak terduga: $e',
      };
    }
  }
}
