import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sibatikgal/app/data/providers/login_service.dart';
import 'package:sibatikgal/app/routes/app_pages.dart';

import '../../../data/providers/oauth_service.dart'; // untuk Get.offAllNamed('/main')

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isLoading = false.obs;
  var isGoogleLoading = false.obs;

  final LoginService _authService = LoginService();
  final GoogleAuthService _googleAuthService = GoogleAuthService();
  final GetStorage _storage = GetStorage();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() async {
    isLoading.value = true;

    final result = await _authService.login(
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    isLoading.value = false;

    if (result['success']) {
      final token = result['data']['access_token'];
      final apiKey = result['data']['api_key'];

      _storage.write('token', token);
      _storage.write('api_key', apiKey);

      Get.snackbar('Berhasil', 'Login Berhasil!',
          backgroundColor: Colors.green, colorText: Colors.white);

      Get.offAllNamed(Routes.MAIN);
    } else {
      Get.snackbar('Gagal', result['message'],
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> loginWithGoogle() async {
    print('🔄 Memulai login dengan Google...');
    isGoogleLoading.value = true;

    try {
      final result = await _googleAuthService.signInAndAuthenticate();

      if (result == null) {
        print('❌ Google Sign-In dibatalkan oleh user');
        Get.snackbar("Login Dibatalkan", "Kamu membatalkan proses login Google",
            backgroundColor: Colors.orange, colorText: Colors.white);
        return;
      }

      if (result['success'] == false) {
        final message = result['message'] ?? 'Google sign-in gagal';
        print('❗ Gagal: $message');
        Get.snackbar("Login Gagal", message,
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }

      final data = result['data'];
      final accessToken = data['access_token'];
      final email = data['email'];
      final apiKey = data['api_key'];

      // print('✅ Login Google berhasil');
      // print('🪪 Token: $accessToken');
      // print('📧 Email: $email');

      _storage.write('token', accessToken);
      _storage.write('api_key', apiKey);
      _storage.write('email', email);

      Get.snackbar("Halo", "Selamat datang, $email",
          backgroundColor: Colors.green, colorText: Colors.white);

      Get.offAllNamed(Routes.MAIN);
    } catch (e) {
      print('❌ ERROR tidak terduga saat login Google: $e');
      Get.snackbar("Terjadi Kesalahan", "Gagal login: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isGoogleLoading.value = false;
      print('✅ Selesai proses login Google');
    }
  }
}
