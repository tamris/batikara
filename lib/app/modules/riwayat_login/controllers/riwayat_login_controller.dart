import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../data/providers/riwayat_login_service.dart';


class RiwayatLoginController extends GetxController {
  final _service = RiwayatLoginService();

  var loginHistory = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  // Tambahan untuk chart
  var chartData = <BarChartGroupData>[].obs;
  var chartLabels = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchLoginHistory();
  }

  Future<void> fetchLoginHistory() async {
    try {
      isLoading.value = true;
      final token = GetStorage().read('token');
      final data = await _service.fetchRiwayatLogin(token);

      loginHistory.assignAll(data.take(7).toList()); // 7 data terakhir

      _generateChartData(data);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void _generateChartData(List<Map<String, dynamic>> data) {
    final countByDate = <String, int>{};
    final formatter = DateFormat('yyyy-MM-dd');

    for (var item in data) {
      final dateStr = item['login_time'].toString().substring(0, 10);
      countByDate[dateStr] = (countByDate[dateStr] ?? 0) + 1;
    }

    final sortedKeys = countByDate.keys.toList()..sort();
    chartLabels.assignAll(sortedKeys);

    chartData.assignAll(List.generate(sortedKeys.length, (index) {
      final date = sortedKeys[index];
      final count = countByDate[date]!;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: count.toDouble(),
            width: 14,
            color: const Color.fromARGB(255, 255, 175, 27), // 💙 warna bar: biru Tailwind-style
            borderRadius:
                BorderRadius.circular(4), // biar ujungnya bulat sedikit
          ),
        ],
      );
    }));
  }

  String formatWaktu(String rawDateTime) {
    final dt = DateTime.parse(rawDateTime).toLocal();
    return DateFormat('dd MMMM yyyy, HH:mm', 'id_ID').format(dt) + ' WIB';
  }
}
