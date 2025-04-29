import 'package:get/get.dart';

import '../controllers/jejak_controller.dart';

class JejakBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JejakController>(
      () => JejakController(),
    );
  }
}
