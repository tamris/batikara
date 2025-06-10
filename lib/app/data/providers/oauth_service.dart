import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../config/app_config.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId: '748779332863-0dimktq94qgevefe0fjafn43b6d5al7l.apps.googleusercontent.com',
  );

  final Dio _dio = Dio(BaseOptions(
    baseUrl: AppConfig.baseUrl,
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
  ));

  Future<Map<String, dynamic>?> signInAndAuthenticate() async {
    try {
      await _googleSignIn.signOut(); // optional
      final account = await _googleSignIn.signIn();
      final auth = await account?.authentication;

      if (auth?.idToken == null) return null;

      final response = await _dio.post(
        '/auth/google', // endpoint relatif terhadap baseUrl
        data: {'token': auth!.idToken},
      );

      return {
        'success': true,
        'data': response.data,
      };
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? 'Gagal login dengan Google';
      return {
        'success': false,
        'message': errorMessage,
      };
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
