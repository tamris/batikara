import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../widgets/loading_overlay.dart';

class LoginView extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Dark overlay
          Container(color: Colors.black.withOpacity(0.4)),

          // Main content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Halo,\nLogin Sekarang',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Belum punya akun?',
                          style: TextStyle(
                            color: Colors.white70,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed('/register');
                          },
                          child: Text(
                            'Daftar',
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Email
                    TextFormField(
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Mohon isi email kamu';
                        }
                        if (!GetUtils.isEmail(value)) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // Password
                    Obx(() => TextFormField(
                          controller: controller.passwordController,
                          obscureText: !controller.isPasswordVisible.value,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: IconButton(
                              icon: Icon(controller.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: controller.togglePasswordVisibility,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            if (value.length < 6) {
                              return 'Password minimal 6 karakter';
                            }
                            return null;
                          },
                        )),
                    SizedBox(height: 10),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Lupa kata sandi?',
                            style: TextStyle(
                                color: Colors.white70,
                                fontFamily: 'Poppins',
                                fontSize: 14),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed('/reset-password');
                            },
                            child: Text(
                              'Reset',
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            controller.login();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),

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

                    SizedBox(height: 20),

                    // Google Login
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

          // Loading Overlay
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
}
