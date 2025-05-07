import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_screen_controller.dart';

class SplashOneView extends GetView<SplashScreenController> {
  const SplashOneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller;
    return Scaffold(
      backgroundColor: Colors.white, // sesuai background gambar
      body: Center(
        child: Image.asset(
          'assets/img/splash1.png', // ganti dengan path asset logo kamu
          width: 400, // kamu bisa sesuaikan ukuran ini
          height: 400,
        ),
      ),
    );
  }
}
