import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotifikasiView extends StatelessWidget {
  const NotifikasiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifikasi',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: isTablet ? 24 : 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/notifications_ilustrasi.png', // Ganti dengan path ikon lonceng Anda
              width: 230,
              height: 230,
            ),
            const SizedBox(height: 24),
            Text(
              'Tidak ada notifikasi',
              style: TextStyle(
                fontSize: isTablet ? 22 : 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 100 : 40),
              child: Text(
                'Jika anda memiliki notifikasi, \nanda akan melihatnya di sini',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isTablet ? 16 : 15,
                  fontFamily: 'Poppins',
                  color: Colors.grey[500],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
