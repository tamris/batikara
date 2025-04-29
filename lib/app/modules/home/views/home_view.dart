import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widget/home_info_card.dart';
import '../widget/home_menu_item.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: const Color(0xFFB66437)),
          SafeArea(
            child: Column(
              children: [
                // const SizedBox(height: 20), // Jarak atas supaya header gak nempel
                // Header
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Kolom Teks (Halo & Greeting)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() => Text(
                                  "Halo ${controller.username},",
                                  style: const TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Poppins'),
                                )),
                            const SizedBox(height: 4),
                            Obx(() => Text(
                                  controller.greeting.value,
                                  style: const TextStyle(
                                      color: Colors.white70,
                                      fontFamily: 'Poppins',
                                      fontSize: 16),
                                )),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 30,
                                  child: Icon(Icons.person),
                                ),
                                const SizedBox(width: 16),
                                Container(
                                  width: 250,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Icon Notif di Kanan
                      GestureDetector(
                        onTap: () {
                          // Aksi ketika diklik
                        },
                        child: Image.asset(
                          'assets/icons/notification.png', // Ganti dengan asset kamu
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                // Konten bawah
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Akses Cepat",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Poppins'),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              HomeMenuItem(
                                imagePath: 'assets/icons/event.png',
                                label: 'Event',
                                onTap: () {
                                  Get.toNamed(
                                      '/event'); // <-- pindah ke route '/event'
                                },
                              ),
                              HomeMenuItem(
                                imagePath: 'assets/icons/jejak.png',
                                label: 'Jejak',
                                onTap: () {
                                  Get.toNamed('/jejak');
                                },
                              ),
                              HomeMenuItem(
                                imagePath: 'assets/icons/quiz.png',
                                label: 'Quiz',
                                onTap: () {
                                  Get.toNamed('/quiz');
                                },
                              ),
                              HomeMenuItem(
                                imagePath: 'assets/icons/aktivitas.png',
                                label: 'Aktivitas',
                                onTap: () {
                                  Get.toNamed('/aktivitas');
                                },
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Informasi",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    fontFamily: 'Poppins'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed(
                                      '/informasi'); // <-- Arahkan ke page baru
                                },
                                child: const Text(
                                  "See All",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Gunakan AspectRatio agar tinggi proporsional
                          Row(
                            children: [
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 3 / 4.5,
                                  child: HomeInfoCard(
                                    // <--- pakai widget baru
                                    title: "Keunikan Motif Batik Tegalan",
                                    imagePath: 'assets/img/informasi1.jpg',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 3 / 4.5,
                                  child: HomeInfoCard(
                                    title:
                                        "Peringati Hari Batik, Dekranasda Kota Tegal akan Gelar Lomba Batik Fashion Show",
                                    imagePath: 'assets/img/informasi2.png',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
