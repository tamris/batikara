import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../config/app_config.dart';

class UserService {
  final _storage = GetStorage();
  final Dio _dio = Dio();

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

      // Jika berhasil
      return response.data;
    } on DioException catch (e) {
      print('❌ Dio error: ${e.response?.statusCode} - ${e.response?.data}');
      return null;
    } catch (e) {
      print('❌ Unexpected error: $e');
      return null;
    }
  }

  Future<bool> updateProfile(Map<String, dynamic> data) async {
    final token = _storage.read('token');
    if (token == null) return false;

    try {
      final response = await _dio.put(
        '${AppConfig.baseUrl}/user/profile',
        data: data,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.statusCode == 200;
    } catch (e) {
      print("❌ Error update profile: $e");
      return false;
    }
  }
}
