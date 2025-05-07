import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() {
    isLoading.value = true;

    // Simulasi login sukses
    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;
      Get.snackbar('Berhasil', 'Login Berhasil!',
          backgroundColor: Colors.green, colorText: Colors.white);

      Get.offAllNamed('/main');
    });
  }
}
