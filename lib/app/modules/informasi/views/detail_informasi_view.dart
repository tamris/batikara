import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailInformasiView extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final DateTime? date;

  const DetailInformasiView({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.description,
    this.date,
  }) : super(key: key);

  String getFormattedDate() {
    if (date == null) return '-';
    return '${date!.day.toString().padLeft(2, '0')} '
        '${_monthName(date!.month)} '
        '${date!.year}';
  }

  String _monthName(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des'
    ];
    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Detail",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar artikel
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/img/placeholder.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Tanggal
            Text(
              "BERITA   |   ${getFormattedDate()}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),

            // Judul
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 16),

            // Isi artikel
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
