import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/providers/user_service.dart';

class SecurityController extends GetxController {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RxBool isCurrentPasswordHidden = true.obs;
  RxBool isNewPasswordHidden = true.obs;
  RxBool isConfirmPasswordHidden = true.obs;

  final _userService = UserService();

  void toggleCurrentPasswordVisibility() =>
      isCurrentPasswordHidden.value = !isCurrentPasswordHidden.value;
  void toggleNewPasswordVisibility() =>
      isNewPasswordHidden.value = !isNewPasswordHidden.value;
  void toggleConfirmPasswordVisibility() =>
      isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;

  void savePassword() async {
    final current = currentPasswordController.text.trim();
    final newPw = newPasswordController.text.trim();
    final confirm = confirmPasswordController.text.trim();

    if (current.isEmpty || newPw.isEmpty || confirm.isEmpty) {
      Get.snackbar("Error", "Semua field wajib diisi",
          backgroundColor: Colors.red.shade300, colorText: Colors.white);
      return;
    }

    if (newPw != confirm) {
      Get.snackbar("Error", "Password baru dan konfirmasi tidak cocok",
          backgroundColor: Colors.red.shade300, colorText: Colors.white);
      return;
    }

    final result = await _userService.changePassword(
      currentPassword: current,
      newPassword: newPw,
      confirmPassword: confirm,
    );

    if (result['success']) {
      Get.snackbar("Berhasil", result['message'],
          backgroundColor: Colors.green.shade300, colorText: Colors.white);
      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
    } else {
      Get.snackbar("Gagal", result['message'],
          backgroundColor: Colors.red.shade300, colorText: Colors.white);
    }
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
