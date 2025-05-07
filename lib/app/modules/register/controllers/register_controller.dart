import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

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

  void register() {
    isLoading.value = true;

    Future.delayed(Duration(seconds: 1), () {
      isLoading.value = false;
      Get.snackbar('Sukses', 'Registrasi berhasil!',
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.offNamed('/otp-verification');
    });
  }
}
