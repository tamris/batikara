import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JejakView extends StatelessWidget {
  const JejakView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFDA7137),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Jejak",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/img/informasi2.png', // Ganti sesuai nama filemu
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Sejarah Batik Tegalan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'KOTA TEGAL - Dalam rangka memperingati Hari Batik Nasional pada tanggal 2 Oktober 2024 mendatang, '
              'Dewan Kerajinan Nasional Daerah (Dekranasda) Kota Tegal akan menyelenggarakan Batik Fashion Show Tegal '
              'Laka-laka dengan tema "Inspiring of The Sea". Hal ini disampaikan Plt. Kepala Dinas Tenaga Kerja dan '
              'Perindustrian (Disnakerin) Kota Tegal, Rita Marlianawati pada saat Rapat Koordinasi persiapan Peringatan '
              'Hari Batik Nasional tahun 2024, Kamis (5/9/2024) di Gedung Dekranasda Kota Tegal, Komplek Balai Kota Tegal.\n\n'
              'Pj. Wali Kota Tegal, Dadang Somantri yang hadir dalam Rakor tersebut menyampaikan apresiasi pada rencana '
              'pelaksanaan Batik Fashion Show Tegal Laka-laka dalam rangka memperingati Hari Batik Nasional tersebut. '
              'Ia mengimbau agar acara tersebut dipersiapkan sebaik mungkin, dan tetap melibatkan penggiat, dan pengrajin '
              'batik tegalan, agar semakin hidup.\n\nIlahasarua.(*)',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Lebih Lengkap nya Bisa Akses Video dengan tekan link dibawah ini !!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  // aksi klik link video
                },
                child: const Text(
                  'Materi Selanjutnya',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
