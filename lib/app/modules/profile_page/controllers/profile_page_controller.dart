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
    final data = await _userService.fetchProfile();
    if (data != null) {
      print("🎯 New profile fetched: $data");
      profileImage.value = data['profile_picture'] ?? '';
      name.value = data['username'] ?? '';
      email.value = data['email'] ?? '';
    }
  }

  // void editProfile() async {
  //   final result = await Get.toNamed('/edit-profile');
  //   if (result == true) {
  //     fetchProfile(); // ⬅️ panggil ulang setelah simpan
  //   }
  // }

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
