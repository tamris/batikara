// lib/controllers/register_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sibatikgal/app/data/providers/register_service.dart';

class RegisterController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  final RegisterService _registerService = RegisterService();

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
}
