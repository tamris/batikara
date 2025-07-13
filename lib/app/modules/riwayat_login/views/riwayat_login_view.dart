import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lottie/lottie.dart';
import '../controllers/riwayat_login_controller.dart';

class RiwayatLoginView extends GetView<RiwayatLoginController> {
  const RiwayatLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat Login',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      backgroundColor: const Color(0xFFF2F4F7),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: SizedBox(
              width: 150,
              height: 150,
              child: Lottie.asset('assets/animations/loading.json'),
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
          children: [
            // Chart login per hari
            if (controller.chartData.isNotEmpty) ...[
              const Text(
                'Grafik Login per Hari',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 250,
                child: BarChart(
                  BarChartData(
                    barGroups: controller.chartData,
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          reservedSize: 28,
                          getTitlesWidget: (value, _) => Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Text(
                              value.toInt().toString(),
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index < 0 || index >= controller.chartLabels.length) return const Text('');
                            final label = controller.chartLabels[index].substring(5); // MM-DD
                            return Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(label, style: const TextStyle(fontSize: 10)),
                            );
                          },
                        ),
                      ),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),

                    // ✅ Tambahkan grid horizontal
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 1,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: Colors.grey.shade300,
                        strokeWidth: 1,
                      ),
                    ),

                    // ✅ Tambahkan border kiri dan bawah (X, Y axis)
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade400, width: 1),
                        left: BorderSide(color: Colors.grey.shade400, width: 1),
                        top: BorderSide.none,
                        right: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Riwayat login kosong
            if (controller.loginHistory.isEmpty)
              Column(
                children: [
                  SizedBox(
                    width: 200,
                    child: Lottie.asset('assets/animations/empty.json'),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Belum ada riwayat login.",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

            // List riwayat login
            ...controller.loginHistory.map((item) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  leading: Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.devices, size: 24, color: const Color.fromARGB(255, 255, 175, 27)),
                  ),
                  title: Text(
                    item['device'],
                    style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      controller.formatWaktu(item['login_time']),
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        );
      }),
    );
  }
}
