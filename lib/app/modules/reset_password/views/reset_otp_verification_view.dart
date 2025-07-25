import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:lottie/lottie.dart';
import '../controllers/reset_otp_verification_controller.dart';

class ResetOtpVerificationView extends StatelessWidget {
  const ResetOtpVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ResetOtpVerificationController>();

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Lottie.asset(
                  'assets/animations/email.json',
                  height: 200,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Verifikasi OTP',
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFDA7137),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Masukkan 6 digit kode yang telah dikirim ke\n${controller.email}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 40),
                PinCodeTextField(
                  length: 6,
                  appContext: context,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(12),
                    fieldHeight: 50,
                    fieldWidth: 45,
                    activeFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    inactiveColor: Colors.grey,
                    activeColor: Color(0xFFDA7137),
                    selectedColor: Color(0xFFDA7137),
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onCompleted: controller.onOtpCompleted,
                  onChanged: (value) {
                    controller.otpCode.value = value;
                  },
                ),
                const SizedBox(height: 20),

                // Error
                Obx(() => controller.errorMessage.value.isNotEmpty
                    ? Text(
                        controller.errorMessage.value,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                        ),
                      )
                    : const SizedBox()),

                const SizedBox(height: 30),

                // Submit button
                Obx(() => controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: controller.otpCode.value.length == 6
                            ? () => controller
                                .onOtpCompleted(controller.otpCode.value)
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDA7137),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Verifikasi',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),
                      )),
                const SizedBox(height: 20),

                TextButton(
                  onPressed: controller.resendOtp,
                  child: const Text(
                    'Kirim ulang kode',
                    style: TextStyle(
                      color: Color(0xFFDA7137),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
