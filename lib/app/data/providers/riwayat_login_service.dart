import 'package:dio/dio.dart';
import '../config/app_config.dart';

class RiwayatLoginService {
  final Dio dio;

  RiwayatLoginService({Dio? dio})
      : dio = dio ?? Dio(BaseOptions(baseUrl: AppConfig.baseUrl));

  Future<List<Map<String, dynamic>>> fetchRiwayatLogin(String token) async {
    try {
      final response = await dio.get(
        '/login-history',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return (data as List).cast<Map<String, dynamic>>();
      } else {
        throw Exception('Gagal memuat riwayat login (${response.statusCode})');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.response?.data ?? e.message}');
    }
  }
}
