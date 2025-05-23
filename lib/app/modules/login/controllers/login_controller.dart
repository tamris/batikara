import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sibatikgal/app/data/providers/login_service.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  final LoginService _authService = LoginService();
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

      // ✅ Simpan token dan apiKey
      _storage.write('token', token);
      _storage.write('api_key', apiKey);

      Get.snackbar('Berhasil', 'Login Berhasil!',
          backgroundColor: Colors.green, colorText: Colors.white);

      Get.offAllNamed('/main');
    } else {
      Get.snackbar('Gagal', result['message'],
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
