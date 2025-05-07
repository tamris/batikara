import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GalleryDetailView extends StatelessWidget {
  const GalleryDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final String batikName = Get.arguments ?? 'Nama Batik';
    final imageName = batikName.toLowerCase().replaceAll(' ', '_');

    // Deskripsi contoh, bisa kamu ganti dengan data dinamis kalau pakai model
    final description = '''
Batik Poci Tahu Aci adalah motif batik khas Tegal yang terinspirasi dari dua kuliner ikonik daerah tersebut, yaitu teh poci dan tahu aci. Motif poci (teko tanah liat) melambangkan kehangatan dan keramahan masyarakat Tegal, sementara tahu aci mencerminkan kreativitas kuliner yang sederhana namun nikmat. Kombinasi keduanya menonjolkan identitas lokal dengan nilai filosofi kehidupan yang bersahaja dan guyub.

Selain simbol kuliner, batik ini juga merepresentasikan kearifan lokal Tegal. Motif poci dengan detail tanah liatnya menggambarkan ketekunan perajin, sedangkan tahu aci menekankan kebersamaan. Warna alamiah seperti coklat dan hijau semakin memperkuat kesan hangat dan alami, menjadikannya warisan budaya yang terus dilestarikan.
''';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          batikName,
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar batik
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/$imageName.jpg',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Nama Batik
            Text(
              batikName,
              style: const TextStyle(
                fontSize: 24,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Deskripsi
            Text(
              description,
              style: const TextStyle(
                  fontSize: 16, height: 1.5, fontFamily: 'Poppins'),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
