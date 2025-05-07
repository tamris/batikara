import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class MaintenanceView extends StatelessWidget {
  const MaintenanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animasi/Gambar Maintenance (Opsional)
              Lottie.asset(
                'assets/animations/maintenance.json', // File Lottie
                width: 300,
                height: 300,
              ),
              const SizedBox(height: 26),
              Text(
                'Sedang Dalam Perbaikan',
                style: TextStyle(
                  fontSize: isTablet ? 28 : 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Kami sedang melakukan peningkatan sistem untuk pengalaman yang lebih baik. Harap coba lagi nanti.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isTablet ? 18 : 16,
                  fontFamily: 'Poppins',
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              // Tombol Kembali (Opsional)
              if (Navigator.of(context).canPop())
                ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Kembali',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
