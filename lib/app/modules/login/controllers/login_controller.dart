import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      // Simulasi login sukses tanpa API
      Future.delayed(Duration(seconds: 2), () {
        isLoading.value = false;
        Get.snackbar('Berhasil', 'Login Berhasil!',
            backgroundColor: Colors.green, colorText: Colors.white);

        // Arahkan ke halaman berikutnya (simulasi)
        Get.offAllNamed('/main');
      });
    }
  }
}
