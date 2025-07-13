import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/scna_page_controller.dart';

class ScnaPageView extends GetView<ScnaPageController> {
  const ScnaPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Deteksi Motif Batik',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() => Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: controller.isCameraInitialized.value
                      ? controller.cameraPreviewWidget.value
                      : const Center(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 100,
                            color: Colors.grey,
                          ),
                        ),
                )),
            const SizedBox(height: 20),

            // Tombol Start / Stop Kamera
            Obx(() => controller.isCameraInitialized.value
                ? ElevatedButton(
                    onPressed: () {
                      controller.stopCamera();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text(
                      'Stop Kamera',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () async {
                      await controller.initializeCamera();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text(
                      'Start Kamera',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                    ),
                  )),
            const SizedBox(height: 30),

            // const Text(
            //   'Arahkan kameranya ke objek batiknya !',
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontFamily: 'Poppins',
            //     fontWeight: FontWeight.w500,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
          ],
        ),
      ),
    );
  }
}
