import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScnaPageController extends GetxController {
  late CameraController cameraController;
  var isCameraInitialized = false.obs;
  var cameraPreviewWidget = Rx<Widget>(Container()); // ✅ fix

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    cameraController = CameraController(
      camera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await cameraController.initialize();
    isCameraInitialized.value = true;
    cameraPreviewWidget.value = CameraPreview(cameraController);
  }

  @override
  void onClose() {
    if (isCameraInitialized.value) {
      cameraController.dispose();
    }
    super.onClose();
  }

  void stopCamera() {
    if (isCameraInitialized.value) {
      cameraController.dispose();
      isCameraInitialized.value = false;
      cameraPreviewWidget.value = Container();
    }
  }
}
