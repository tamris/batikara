import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/scna_page_controller.dart';

class ScanPageView extends StatelessWidget {
  final controller = Get.put(ScanPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Deteksi Batik Real-Time',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Kamera Preview
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 400,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: controller.started.value &&
                      controller.isCameraInitialized.value
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: AspectRatio(
                        aspectRatio:
                            controller.cameraController.value.aspectRatio,
                        child: CameraPreview(controller.cameraController),
                      ),
                    )
                  : const Center(
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 100,
                        color: Colors.grey,
                      ),
                    ),
            ),

            const SizedBox(height: 12),

            // Tombol swap kamera
            // if (controller.isCameraInitialized.value)
            //   IconButton(
            //     icon: const Icon(Icons.cameraswitch),
            //     onPressed: () => controller.swapCamera(),
            //     tooltip: 'Ganti Kamera',
            //     iconSize: 30,
            //     color: Colors.black87,
            //   ),

            // const SizedBox(height: 16),

            // Box hasil deteksi scrollable
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              constraints: const BoxConstraints(
                minHeight: 100,
                maxHeight: 200,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Motif: ${controller.label.value.isEmpty ? '-' : controller.label.value}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Makna Motif:',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    SelectableText(
                      controller.makna.value.isEmpty
                          ? 'Belum ada hasil deteksi.'
                          : controller.makna.value,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Tombol Mulai / Stop
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.started.value
                      ? ElevatedButton.icon(
                          onPressed: controller.stopDeteksi,
                          icon: const Icon(Icons.stop),
                          label: const Text("Stop"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(fontFamily: 'Poppins'),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        )
                      : ElevatedButton.icon(
                          onPressed: controller.startDeteksi,
                          icon: const Icon(Icons.play_arrow),
                          label: const Text("Mulai Deteksi"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(fontFamily: 'Poppins'),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
