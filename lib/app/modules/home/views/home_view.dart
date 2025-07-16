import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/config/app_config.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
import '../widget/home_info_card.dart';
import '../widget/home_menu_item.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      body: Stack(
        children: [
          Container(color: const Color(0xFFDA7137)),
          SafeArea(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 24 : 16,
                    vertical: isTablet ? 24 : 16,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() => Text(
                                  "Halo ${controller.username},",
                                  style: TextStyle(
                                    fontSize: isTablet ? 42 : 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  ),
                                )),
                            const SizedBox(height: 4),
                            Obx(() => Text(
                                  controller.greeting.value,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontFamily: 'Poppins',
                                    fontSize: isTablet ? 20 : 16,
                                  ),
                                )),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Obx(() => CircleAvatar(
                                      radius: 30,
                                      backgroundImage: controller
                                              .profileImage.isEmpty
                                          ? const AssetImage(
                                              'assets/icons/avatar.png')
                                          : NetworkImage(
                                                  '${AppConfig.baseUrl}${controller.profileImage}')
                                              as ImageProvider,
                                    )),

                                const SizedBox(width: 16),
                                // Container(
                                //   width: isTablet ? 400 : 250,
                                //   height: isTablet ? 70 : 60,
                                //   decoration: BoxDecoration(
                                //     color: Colors.grey.shade300,
                                //     borderRadius: BorderRadius.circular(10),
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Aksi ketika notif diklik
                          Get.toNamed(Routes.NOTIFIKASI);
                        },
                        child: Image.asset(
                          'assets/icons/notification.png',
                          width: isTablet ? 32 : 25,
                          height: isTablet ? 32 : 25,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
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
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 24 : 16,
                        vertical: isTablet ? 32 : 24,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Akses Cepat",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: isTablet ? 20 : 16,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 18),

                            // Gunakan Wrap untuk responsivitas
                            Align(
                              alignment: Alignment.topCenter,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  double itemWidth = isTablet
                                      ? 120
                                      : constraints.maxWidth / 4 - 20;

                                  return Wrap(
                                    spacing: 20,
                                    runSpacing: 20,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: itemWidth,
                                        child: HomeMenuItem(
                                          imagePath: 'assets/icons/event.png',
                                          label: 'Event',
                                          onTap: () => Get.toNamed('/event'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: itemWidth,
                                        child: HomeMenuItem(
                                          imagePath: 'assets/icons/jejak.png',
                                          label: 'Jejak',
                                          onTap: () => Get.toNamed('/jejak'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: itemWidth,
                                        child: HomeMenuItem(
                                          imagePath: 'assets/icons/vdo.png',
                                          label: 'Video',
                                          onTap: () => Get.toNamed('/video'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: itemWidth,
                                        child: HomeMenuItem(
                                          imagePath:
                                              'assets/icons/aktivitas.png',
                                          label: 'Analysis',
                                          onTap: () => Get.toNamed('/analisis'),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),

                            const SizedBox(height: 18),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Informasi",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isTablet ? 20 : 16,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Get.toNamed(Routes.INFORMASI),
                                  child: Text(
                                    "See All",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontFamily: 'Poppins',
                                      fontSize: isTablet ? 18 : 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Obx(() {
                              if (controller.articles.isEmpty) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              return Row(
                                children: controller.articles
                                    .map((article) {
                                      return Expanded(
                                        child: AspectRatio(
                                          aspectRatio: 3 / 4.5,
                                          child: HomeInfoCard(
                                            article: article,
                                            imageWidget: Image.network(
                                              '${AppConfig.baseUrl}${article.imageUrl}',
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                  'assets/img/placeholder.jpg',
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                    .toList()
                                    .expand((widget) sync* {
                                      yield widget;
                                      yield const SizedBox(width: 12);
                                    })
                                    .toList()
                                  ..removeLast(), // menghapus spasi terakhir
                              );
                            }),
                          ],
                        ),
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
