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
      title: '',
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      content: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.logout, size: 40, color: Colors.red),
          ),
          const SizedBox(height: 20),
          const Text(
            "Logout dari aplikasi?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Apakah Anda yakin ingin keluar?",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("Batal",
                    style: TextStyle(fontFamily: 'Poppins')),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  _storage.erase(); // Hapus token
                  Get.offAllNamed('/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Logout",
                    style: TextStyle(fontFamily: 'Poppins')),
              ),
            ],
          ),
        ],
      ),
      radius: 15,
      barrierDismissible: false,
    );
  }
}
