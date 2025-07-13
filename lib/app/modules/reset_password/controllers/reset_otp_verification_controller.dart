// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/providers/reset_password_service.dart';

class ResetOtpVerificationController extends GetxController {
  final ResetPasswordService _service = ResetPasswordService();

  late String email;
  var otpCode = ''.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Ambil email dari halaman sebelumnya
    email = Get.arguments as String;
  }

  // Saat OTP selesai diinput
  Future<void> onOtpCompleted(String code) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await _service.verifyResetOtp(email, code);

      if (result['success']) {
        // Arahkan ke halaman input password baru
        Get.toNamed('/reset/new-password', arguments: email);
      } else {
        errorMessage.value = result['message'];
      }
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan saat verifikasi OTP';
    } finally {
      isLoading.value = false;
    }
  }

  // Kirim ulang OTP
  Future<void> resendOtp() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await _service.sendResetOtp(email);
      errorMessage.value = result['message'];
    } catch (e) {
      errorMessage.value = 'Gagal mengirim ulang OTP';
    } finally {
      isLoading.value = false;
    }
  }
}
