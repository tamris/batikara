import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../../../data/providers/riwayat_login_service.dart';

class RiwayatLoginController extends GetxController {
  final _service = RiwayatLoginService();

  var loginHistory = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLoginHistory();
  }

  Future<void> fetchLoginHistory() async {
    try {
      isLoading.value = true;
      final token = GetStorage().read('token');
      // ← Ganti ini nanti
      final data = await _service.fetchRiwayatLogin(token);
      loginHistory.assignAll(data.take(7).toList());
      // loginHistory.assignAll(data);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  String formatWaktu(String rawDateTime) {
    final dt = DateTime.parse(rawDateTime).toLocal();
    return DateFormat('dd MMMM yyyy, HH:mm', 'id_ID').format(dt) + ' WIB';
  }
}
