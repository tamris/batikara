import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sibatikgal/app/modules/profile_page/views/profile_page_view.dart';
import 'package:sibatikgal/app/modules/scna_page/views/scna_page_view.dart';
import '../../galery/views/galery_view.dart';
import '../../home/views/home_view.dart';
import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  final List<Widget> pages = [
    HomeView(),
    GalleryView(),
    ScnaPageView(),      // <-- Ini halaman Scan
    Center(child: Text('Mapping')),
    ProfilePageView()
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: pages[controller.currentIndex.value],
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.changePage(2); // <-- Pindah ke halaman Scan
            },
            child: Icon(Icons.qr_code_scanner, color: Colors.black),
            backgroundColor: Colors.grey[300],
            shape: CircleBorder(),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 6.0,
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home, "Beranda", 0),
                  _buildNavItem(Icons.account_balance, "GaleryBatik", 1),
                  SizedBox(width: 30), // Space buat FAB di tengah
                  _buildNavItem(Icons.map, "Mapping", 3),
                  _buildNavItem(Icons.person, "Profil", 4),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = controller.currentIndex.value == index;
    return GestureDetector(
      onTap: () => controller.changePage(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? Colors.blue : Colors.grey),
          Text(label, style: TextStyle(color: isSelected ? Colors.blue : Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
