import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/mapping_controller.dart';

class MappingView extends GetView<MappingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/img/mapp.jpg', // Ganti sesuai path gambarmu
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
