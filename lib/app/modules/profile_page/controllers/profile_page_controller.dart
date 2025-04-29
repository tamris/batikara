import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePageController extends GetxController {
  void editProfile() {
    // Aksi saat klik Edit Profile
    Get.toNamed('/edit-profile');
  }

  void goToHistory() {
    // Aksi Riwayat
    Get.snackbar("Riwayat", "Navigasi ke Riwayat Pengenalan Batik.");
  }

  void goToFavorite() {
    // Aksi Favorit
    Get.snackbar("Favorit", "Navigasi ke Favorit.");
  }

  void goToSecurity() {
    // Aksi Keamanan
    Get.toNamed('/security');
  }

  void goToAbout() {
    // Aksi Tentang Aplikasi
    Get.snackbar("Tentang Aplikasi", "Navigasi ke Tentang Aplikasi.");
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
