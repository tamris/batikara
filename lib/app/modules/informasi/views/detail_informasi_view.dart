import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailInformasiView extends StatelessWidget {
  final String title;
  final String imagePath;

  const DetailInformasiView({
    Key? key,
    required this.title,
    required this.imagePath,
  }) : super(key: key);

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
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "BERITA   |   05 Sep 2024",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "KOTA TEGAL - Dalam rangka memperingati Hari Batik Nasional pada tanggal 2 Oktober 2024 mendatang, Dewan Kerajinan Nasional Daerah (Dekranasda) Kota Tegal akan menyelenggarakan Batik Fashion Show Tegal Laka-laka dengan tema \"Inspiring of The Sea\". Hal ini disampaikan Plt. Kepala Dinas Tenaga Kerja dan Perindustrian (Disnakerin) Kota Tegal, Rita Marlianawati pada saat Rapat Koordinasi persiapan Peringatan Hari Batik Nasional tahun 2024, Kamis (5/9/2024) di Gedung Dekranasda Kota Tegal, Komplek Balai Kota Tegal.\n\nPj. Wali Kota Tegal, Dading Somantri yang hadir dalam Rakor tersebut menyampaikan apresiasi pada rencana pelaksanaan Batik Fashion Show Tegal Laka-laka dalam rangka memperingati Hari Batik Nasional tersebut. Ia mengimbau agar acara tersebut dipersiapkan sebaik mungkin, dan tetap melibatkan penggiat, dan pengrajin batik agar semakin dikenal.\n\nIlahsasuar.(*),",
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
