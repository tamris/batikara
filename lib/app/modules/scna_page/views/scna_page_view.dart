import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/scna_page_controller.dart';

class ScnaPageView extends GetView<ScnaPageController> {
  const ScnaPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ScnaPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ScnaPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
