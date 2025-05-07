import 'package:get/get.dart';

class FavoritController extends GetxController {
  final allItems = [
    'Gribigian',
    'Jago Mogok',
    'Kembang Pacar',
    'Poci Tahu Aci',
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
        allItems
            .where((item) => item.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }
}
