import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../../../data/providers/deteksi_service.dart';

class ScanPageController extends GetxController {
  late CameraController cameraController;
  List<CameraDescription> cameras = [];
  int currentCameraIndex = 0;

  var isCameraInitialized = false.obs;
  var started = false.obs;

  var label = ''.obs;
  var confidence = 0.0.obs;
  var makna = ''.obs;

  Timer? _timer;
  int _elapsedSeconds = 0;
  final int maxDetectionSeconds = 15;

  DateTime lastDetectionTime =
      DateTime.now().subtract(const Duration(seconds: 5));
  String _lastSavedLabel = '';
  DateTime _lastSavedTime =
      DateTime.now().subtract(const Duration(seconds: 10));

  Future<void> startDeteksi() async {
    started.value = true;
    _elapsedSeconds = 0;
    _lastSavedLabel = '';
    _lastSavedTime = DateTime.now().subtract(const Duration(seconds: 10));
    await _initCamera();
  }

  Future<void> stopDeteksi() async {
    _timer?.cancel();
    if (isCameraInitialized.value) {
      await cameraController.dispose();
      isCameraInitialized.value = false;
    }

    label.value = '';
    confidence.value = 0.0;
    makna.value = '';
    started.value = false;
  }

  Future<void> _initCamera() async {
    try {
      cameras = await availableCameras();
      currentCameraIndex = 0;

      cameraController = CameraController(
        cameras[currentCameraIndex],
        ResolutionPreset.medium,
      );
      await cameraController.initialize();
      await cameraController.setFlashMode(FlashMode.auto);

      isCameraInitialized.value = true;
      _startRealtimeDetection();
    } catch (e) {
      Get.snackbar('Error', 'Gagal inisialisasi kamera: $e');
    }
  }

  Future<void> swapCamera() async {
    if (cameras.isEmpty) return;

    _timer?.cancel();

    try {
      await cameraController.dispose();
      currentCameraIndex = (currentCameraIndex + 1) % cameras.length;
      cameraController = CameraController(
        cameras[currentCameraIndex],
        ResolutionPreset.medium,
      );
      await cameraController.initialize();
      isCameraInitialized.value = true;

      _startRealtimeDetection();
    } catch (e) {
      Get.snackbar('Error', 'Gagal ganti kamera: $e');
    }
  }

  void _startRealtimeDetection() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      _elapsedSeconds += 1;
      if (_elapsedSeconds > maxDetectionSeconds) {
        stopDeteksi();
        return;
      }

      // ⏱️ Deteksi hanya dilakukan setiap 5 detik
      if (DateTime.now().difference(lastDetectionTime).inSeconds < 5) return;

      try {
        final file = await _captureImage();
        await _deteksi(file);
        lastDetectionTime = DateTime.now();
      } catch (e) {
        print('Gagal deteksi: $e');
        label.value = 'Error';
        confidence.value = 0.0;
        makna.value = 'Gagal mendeteksi gambar.';
      }
    });
  }

  Future<File> _captureImage() async {
    final dir = await getTemporaryDirectory();
    final filePath =
        join(dir.path, '${DateTime.now().millisecondsSinceEpoch}.jpg');
    await cameraController.takePicture().then((file) => file.saveTo(filePath));
    return File(filePath);
  }

  Future<void> _deteksi(File image) async {
    final result = await DeteksiService.deteksiBatik(image);
    if (result['success']) {
      final detectedLabel = result['label'];
      final detectedConfidence =
          double.tryParse(result['confidence'].toString()) ?? 0.0;

      label.value = detectedLabel;
      confidence.value = detectedConfidence;
      makna.value = result['makna'] ?? 'Makna tidak tersedia';

      // ❌ Jangan simpan duplikat label dalam 10 detik terakhir
      if (_lastSavedLabel != detectedLabel ||
          DateTime.now().difference(_lastSavedTime).inSeconds >= 10) {
        await DeteksiService.simpanRiwayat(image);
        _lastSavedLabel = detectedLabel;
        _lastSavedTime = DateTime.now();
      }
    } else {
      label.value = 'Error';
      confidence.value = 0.0;
      makna.value = result['error'] ?? 'Terjadi kesalahan saat deteksi';
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    if (isCameraInitialized.value) {
      cameraController.dispose();
    }
    super.onClose();
  }
}
