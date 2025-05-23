import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sibatikgal/app/modules/mapping/views/mapping_view.dart';
import 'package:sibatikgal/app/modules/profile_page/views/profile_page_view.dart';
import 'package:sibatikgal/app/modules/scan_page/views/scna_page_view.dart';
import '../../galery/views/galery_view.dart';
import '../../home/views/home_view.dart';
import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  final List<Widget> pages = [
    HomeView(),
    GalleryView(),
    ScnaPageView(),
    MappingView(),
    ProfilePageView()
  ];

  @override
  Widget build(BuildContext context) {
    // deteksi apakah keyboard sedang muncul
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Obx(() => Scaffold(
          body: pages[controller.currentIndex.value],
          // Sembunyikan FAB saat keyboard muncul
          floatingActionButton: isKeyboardOpen
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    controller.changePage(2);
                  },
                  backgroundColor: const Color.fromARGB(255, 241, 241, 241),
                  shape: const CircleBorder(),
                  child: Obx(() {
                    final isSelected = controller.currentIndex.value == 2;
                    return Image.asset(
                      'assets/icons/scan.png',
                      width: 28,
                      height: 28,
                      color: isSelected ? Colors.blue : Colors.black,
                    );
                  }),
                ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 6.0,
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem('assets/icons/home.png', "Beranda", 0),
                  _buildNavItem('assets/icons/gallery.png', "GaleriBatik", 1),
                  const SizedBox(width: 30), // Space for FAB
                  _buildNavItem('assets/icons/map.png', "Mapping", 3),
                  _buildNavItem('assets/icons/profile.png', "Profil", 4),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildNavItem(String assetPath, String label, int index) {
    final isSelected = controller.currentIndex.value == index;
    return GestureDetector(
      onTap: () => controller.changePage(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            assetPath,
            width: 24,
            height: 24,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
