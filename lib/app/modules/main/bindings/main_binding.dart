import 'package:get/get.dart';
import 'package:sibatikgal/app/modules/mapping/controllers/mapping_controller.dart';

import '../../galery/controllers/galery_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../profile_page/controllers/profile_page_controller.dart';
import '../../scan_page/controllers/scna_page_controller.dart';
import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut<GalleryController>(() => GalleryController());
    Get.lazyPut<ScnaPageController>(() => ScnaPageController());
    Get.lazyPut<ProfilePageController>(() => ProfilePageController());
    Get.lazyPut<MappingController>(() => MappingController());
  }
}
