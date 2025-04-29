import 'package:get/get.dart';

import '../controllers/scna_page_controller.dart';

class ScnaPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScnaPageController>(
      () => ScnaPageController(),
    );
  }
}
