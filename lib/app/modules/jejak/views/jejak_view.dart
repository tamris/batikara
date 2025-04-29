import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/jejak_controller.dart';

class JejakView extends GetView<JejakController> {
  const JejakView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JejakView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'JejakView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
