import 'package:get/get.dart';
import '../../../data/models/riwayat_model.dart';
import '../../../data/models/statistik_model.dart';
import '../../../data/providers/riwayat_service.dart';

class RiwayatController extends GetxController {
  // Observable state
  var isLoading = false.obs;
  var riwayatList = <RiwayatModel>[].obs;
  var statistikList = <StatistikModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRiwayat();
    fetchStatistik();
  }

  // Ambil riwayat deteksi dari API
  Future<void> fetchRiwayat() async {
    isLoading.value = true;
    try {
      final data = await RiwayatService.getRiwayat();
      riwayatList.value =
          data.map((json) => RiwayatModel.fromJson(json)).toList();
    } catch (e) {
      Get.snackbar('Gagal memuat riwayat', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Ambil statistik deteksi per label dari API
  Future<void> fetchStatistik() async {
    try {
      final data = await RiwayatService.getDetectionStats();
      statistikList.value =
          data.map((json) => StatistikModel.fromJson(json)).toList();

      print('📊 Statistik List: ${statistikList.length}');
      for (var item in statistikList) {
        print('➡️ ${item.label} - ${item.count}');
      }
    } catch (e) {
      print("❌ Gagal ambil data statistik: $e");
    }
  }
}
