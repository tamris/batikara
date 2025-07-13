import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/providers/reset_password_service.dart';

class ResetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final ResetPasswordService _service = ResetPasswordService();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email wajib diisi';
    }
    if (!GetUtils.isEmail(value.trim())) {
      return 'Format email tidak valid';
    }
    return null;
  }

  Future<void> resetPassword() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    errorMessage.value = '';

    final email = emailController.text.trim();

    try {
      final result = await _service.sendResetOtp(email);

      if (!result['success']) {
        errorMessage.value = result['message'];
        return;
      }

      Get.toNamed('/reset/verify', arguments: email);
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan. Silakan coba lagi.';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
