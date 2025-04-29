import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecurityController extends GetxController {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isCurrentPasswordHidden = true.obs;
  var isNewPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  void toggleCurrentPasswordVisibility() {
    isCurrentPasswordHidden.value = !isCurrentPasswordHidden.value;
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordHidden.value = !isNewPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  void savePassword() {
    // Logika untuk ganti password
    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar(
        "Error",
        "Password baru dan konfirmasi tidak sama!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Bisa tambahkan API request di sini untuk update password
    Get.snackbar(
      "Berhasil",
      "Password berhasil diubah!",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    Get.back(); // Kembali ke halaman sebelumnya
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
