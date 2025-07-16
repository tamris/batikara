import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

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
                'assets/img/sejarah.jpg', // Ganti sesuai nama filemu
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
              'Sejarah Batik Tegalan berawal dari akulturasi budaya yang unik antara tradisi Keraton Mataram dan karakter masyarakat pesisir Tegal. Puncak perkembangannya terjadi pada abad ke-17 ketika para pengikut Amangkurat I dari Mataram mengungsi ke Tegal dan membawa serta keahlian membatik khas keraton. Di Tegal, teknik batik yang cenderung kaku dan halus ini berpadu dengan budaya lokal yang dinamis, melahirkan gaya batik baru yang khas. Perpaduan inilah yang membentuk identitas Batik Tegalan sebagai jembatan antara corak klasik pedalaman dan semangat kebebasan khas pesisir utara Jawa.\n\n'
              'Karakteristik utama Batik Tegalan terletak pada warnanya yang tegas dan klasik—didominasi oleh sogan (cokelat), biru tua, dan hitam—serta goresan motifnya yang cenderung lebih besar dan bebas. Motif-motifnya kaya akan filosofi yang terinspirasi dari alam dan kehidupan sehari-hari, seperti Beras Wutah yang melambangkan kemakmuran dan Gedhong Kosong sebagai pengingat akan kerendahan hati. Melalui motif dan warnanya yang khas, Batik Tegalan tidak hanya menjadi selembar kain, tetapi juga cerminan sejarah dan kearifan lokal yang terus dijaga dan dikembangkan hingga saat ini.',
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
                onTap: () async {
                  // Jadikan fungsinya async
                  // Ganti URL ini dengan link YouTube yang Anda inginkan
                  final Uri url = Uri.parse(
                      'https://youtu.be/riMV6didcKY?si=37PZle3rcs0JKVQS');

                  if (!await launchUrl(url)) {
                    // Jika gagal membuka URL, tampilkan pesan error di console
                    print('Could not launch $url');
                  }
                },
                child: const Text(
                  'Materi Selanjutnya',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor:
                        Colors.blue, // Opsional: agar warna garis bawah sama
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
