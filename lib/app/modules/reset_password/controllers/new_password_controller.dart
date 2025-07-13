import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/providers/reset_password_service.dart';

class NewPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;

  final ResetPasswordService _service = ResetPasswordService();
  late String email;

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments ?? ''; // Ambil email dari arguments route
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password wajib diisi';
    if (value.length < 6) return 'Password minimal 6 karakter';
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Konfirmasi password wajib diisi';
    if (value != passwordController.text) return 'Password tidak sama';
    return null;
  }

  Future<void> submitNewPassword() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      final result = await _service.confirmNewPassword(
        email: email,
        password: passwordController.text,
      );

      if (result['success']) {
        Get.snackbar('Berhasil', result['message'],
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAllNamed('/login');
      } else {
        Get.snackbar('Gagal', result['message'],
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
