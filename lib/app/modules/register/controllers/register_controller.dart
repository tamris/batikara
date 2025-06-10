// lib/controllers/register_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sibatikgal/app/data/providers/register_service.dart';

import '../../../data/providers/oauth_service.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isLoading = false.obs;
  var isGoogleLoading = false.obs;

  final RegisterService _registerService = RegisterService();
  final GoogleAuthService _googleAuthService = GoogleAuthService();
  final GetStorage _storage = GetStorage();

  bool isValidEmail(String value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value);
  }

  bool isValidPassword(String value) {
    return value.length >= 6;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void register() async {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (!isValidEmail(email)) {
      Get.snackbar('Error', 'Email tidak valid',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (!isValidPassword(password)) {
      Get.snackbar('Error', 'Password minimal 6 karakter',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Password tidak cocok',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    final result = await _registerService.register(
      username: username,
      email: email,
      password: password,
    );

    isLoading.value = false;

    if (result['success']) {
      Get.snackbar('Berhasil', result['message'],
          backgroundColor: Colors.green, colorText: Colors.white);

      // Simpan email untuk digunakan saat verifikasi OTP
      Get.toNamed('/otp-verification', arguments: {'email': email});
    } else {
      Get.snackbar('Gagal', result['message'],
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> loginWithGoogle() async {
    isGoogleLoading.value = true;

    final result = await _googleAuthService.signInAndAuthenticate();

    isGoogleLoading.value = false;

    if (result == null || result['success'] == false) {
      final message =
          result?['message'] ?? 'Google sign-in gagal atau dibatalkan';
      Get.snackbar("Login Gagal", message,
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    final data = result['data'];
    final accessToken = data['access_token'];
    final email = data['email'];

    _storage.write('token', accessToken);
    _storage.write('email', email);

    Get.snackbar("Halo", "Selamat datang, $email",
        backgroundColor: Colors.green, colorText: Colors.white);

    Get.offAllNamed(Routes.MAIN);
  }
}
