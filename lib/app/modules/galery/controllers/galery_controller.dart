// controller/gallery_controller.dart
import 'package:get/get.dart';

class GalleryController extends GetxController {
  final allItems = [
    'Kawung', 'Parang', 'Truntum', 'Mega Mendung',
    'Sekar Jagad', 'Lereng', 'Ceplok', 'Nitik',
    'Sido Mukti', 'Gurdo', 'Tambal', 'Sawat'
  ].obs;

  final filteredItems = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredItems.assignAll(allItems);
  }

  void search(String query) {
    if (query.isEmpty) {
      filteredItems.assignAll(allItems);
    } else {
      filteredItems.assignAll(
        allItems.where((item) => item.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }
}