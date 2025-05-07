import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePageController extends GetxController {
  void editProfile() {
    // Aksi saat klik Edit Profile
    Get.toNamed('/edit-profile');
  }

  void goToHistory() {
    // Aksi Riwayat
    Get.toNamed('/riwayat');
  }

  void goToFavorite() {
    // Aksi Favorit
    Get.toNamed('/favorit');
  }

  void goToSecurity() {
    // Aksi Keamanan
    Get.toNamed('/security');
  }

  void goToAbout() {
    // Aksi Tentang Aplikasi
    Get.toNamed('/about-app');
  }

  void logout() {
    // Aksi Logout
    Get.defaultDialog(
      title: "Konfirmasi Logout",
      middleText: "Apakah Anda yakin ingin keluar?",
      textCancel: "Batal",
      textConfirm: "OK",
      confirmTextColor: Get.isDarkMode ? null : Colors.white,
      onConfirm: () {
        Get.offAllNamed(
            '/login'); // ini akan hapus semua halaman sebelumnya dan langsung ke login
      },
    );
  }
}
