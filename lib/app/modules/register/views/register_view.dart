import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';
import '../widgets/loading_overlay.dart';

class RegisterView extends GetView<RegisterController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.4)),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Buat Akun Baru',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 30),
                    buildTextField(
                      controller.usernameController,
                      hintText: "Name",
                      validator: (value) => value == null || value.isEmpty
                          ? 'Tolong isi Nama kamu'
                          : null,
                    ),
                    SizedBox(height: 20),
                    buildTextField(
                      controller.emailController,
                      hintText: "Email",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Mohon isi email kamu';
                        }
                        if (!controller.isValidEmail(value)) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Obx(() => buildTextField(
                          controller.passwordController,
                          hintText: "Password",
                          obscureText: !controller.isPasswordVisible.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            if (!controller.isValidPassword(value)) {
                              return 'Password minimal 6 karakter';
                            }
                            return null;
                          },
                        )),
                    SizedBox(height: 20),
                    Obx(() => buildTextField(
                          controller.confirmPasswordController,
                          hintText: "Konfirmasi Password",
                          obscureText: !controller.isPasswordVisible.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                          validator: (value) {
                            if (value != controller.passwordController.text) {
                              return 'Password tidak sama';
                            }
                            return null;
                          },
                        )),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          'Sudah punya akun?',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () => Get.toNamed('/login'),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Obx(() => SizedBox(
                          width: 400,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              disabledBackgroundColor:
                                  Colors.orange, // <-- tetap orange
                              disabledForegroundColor:
                                  Colors.white, // <-- tetap putih
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: controller.isLoading.value
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      controller.register();
                                    }
                                  },
                            child: Text(
                              'Daftar',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        )),

                    SizedBox(height: 20),

                    // Atau
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.white70)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'atau',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.white70)),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          controller.loginWithGoogle();
                        },
                        icon: Image.asset(
                          'assets/img/google.png',
                          height: 28,
                          width: 28,
                        ),
                        label: Text(
                          'Lanjutkan dengan Google',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(() {
            return (controller.isLoading.value ||
                    controller.isGoogleLoading.value)
                ? const LoadingOverlay()
                : const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Widget buildTextField(
    TextEditingController controller, {
    required String hintText,
    bool obscureText = false,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return SizedBox(
      width: 400,
      height: 60,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        style: TextStyle(color: Colors.black), // warna teks disesuaikan
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white, // <-- diubah jadi solid
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          errorStyle: TextStyle(color: Colors.redAccent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
