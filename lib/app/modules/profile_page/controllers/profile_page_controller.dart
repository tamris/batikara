import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/providers/user_service.dart';

class ProfilePageController extends GetxController {
  final _storage = GetStorage();
  final _userService = UserService();

  var name = ''.obs;
  var email = ''.obs;
  var profileImage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile(); // 👈 panggil saat controller diinit
  }

  void fetchProfile() async {
    final profile = await _userService.fetchProfile();
    if (profile != null) {
      name.value = profile['username'] ?? 'User';
      email.value = profile['email'] ?? 'user@example.com';
      profileImage.value = profile['profile_picture'] ?? '';
      print("✅ Profile loaded: ${name.value}");
    } else {
      print("❌ Gagal ambil profil di ProfilePage");
    }
  }

  void editProfile() {
    Get.toNamed('/edit-profile');
  }

  void goToHistory() {
    Get.toNamed('/riwayat');
  }

  void goToHistoryLogin() {
    Get.toNamed('/riwayat-login');
  }

  void goToFavorite() {
    Get.toNamed('/favorit');
  }

  void goToSecurity() {
    Get.toNamed('/security');
  }

  void goToAbout() {
    Get.toNamed('/about-app');
  }

  void logout() {
    Get.defaultDialog(
      title: "Konfirmasi Logout",
      middleText: "Apakah Anda yakin ingin keluar?",
      textCancel: "Batal",
      textConfirm: "OK",
      confirmTextColor: Get.isDarkMode ? null : Colors.white,
      onConfirm: () {
        _storage.erase(); // Optional: hapus token saat logout
        Get.offAllNamed('/login');
      },
    );
  }
}
