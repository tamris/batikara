import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/security_controller.dart';

class SecurityView extends GetView<SecurityController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDA7137),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Center(
              child: Text(
                "Ganti Password",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              ),
            ),
            const SizedBox(height: 40),
            _buildPasswordField(
              controller.currentPasswordController,
              "Password Sekarang",
              controller.isCurrentPasswordHidden,
              controller.toggleCurrentPasswordVisibility,
            ),
            const SizedBox(height: 16),
            _buildPasswordField(
              controller.newPasswordController,
              "Password Baru",
              controller.isNewPasswordHidden,
              controller.toggleNewPasswordVisibility,
            ),
            const SizedBox(height: 16),
            _buildPasswordField(
              controller.confirmPasswordController,
              "Konfirmasi Password Baru",
              controller.isConfirmPasswordHidden,
              controller.toggleConfirmPasswordVisibility,
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: controller.savePassword,
                child: const Text(
                  "Simpan",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(
    TextEditingController textController,
    String label,
    RxBool isHidden,
    VoidCallback toggleVisibility,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Obx(
          () => TextField(
            controller: textController,
            obscureText: isHidden.value,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'password',
              suffixIcon: IconButton(
                icon: Icon(
                  isHidden.value ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: toggleVisibility,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ),
      ],
    );
  }
}
