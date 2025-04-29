import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/aktivitas_controller.dart';

class AktivitasView extends GetView<AktivitasController> {
  const AktivitasView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AktivitasView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AktivitasView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
