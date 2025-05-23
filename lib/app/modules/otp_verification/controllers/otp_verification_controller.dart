import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sibatikgal/app/data/providers/otp_service.dart';

class OtpVerificationController extends GetxController {
  var otpCode = ''.obs;
  var isLoading = false.obs;

  final OtpService _otpService = OtpService();
  late final String email;

  @override
  void onInit() {
    super.onInit();
    // Ambil email dari arguments
    email = Get.arguments['email'] ?? '';
  }

  void onOtpCompleted(String code) async {
    otpCode.value = code;
    isLoading.value = true;

    final result = await _otpService.verifyOtp(
      email: email,
      otp: code,
    );

    isLoading.value = false;

    if (result['success']) {
      Get.snackbar('Berhasil', result['message'],
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.offAllNamed('/login'); // Navigasi ke halaman login
    } else {
      Get.snackbar('Gagal', result['message'],
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void resendOtp() async {
    isLoading.value = true;

    final result = await _otpService.resendOtp(email: email);

    isLoading.value = false;

    if (result['success']) {
      Get.snackbar('Berhasil', result['message'],
          backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      Get.snackbar('Gagal', result['message'],
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
