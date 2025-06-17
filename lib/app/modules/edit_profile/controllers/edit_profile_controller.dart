import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/providers/user_service.dart';

class EditProfileController extends GetxController {
  final _userService = UserService();

  final nameController = TextEditingController();
  final emailController = TextEditingController(); // non-editable

  var selectedGender = 'Laki-Laki'.obs;
  var birthDate = ''.obs;
  var profileImage = ''.obs;

  // Versi backend untuk submit (yyyy-MM-dd)
  String get birthDateForBackend {
    try {
      return DateFormat('yyyy-MM-dd').format(
        DateFormat("d MMMM yyyy", "id_ID").parse(birthDate.value),
      );
    } catch (_) {
      return '';
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  void loadProfileData() async {
    final profile = await _userService.fetchProfile();
    if (profile != null) {
      profileImage.value = profile['profile_picture'] ?? '';
      nameController.text = profile['username'] ?? '';
      emailController.text = profile['email'] ?? '';
      selectedGender.value = profile['gender'] ?? 'Laki-Laki';

      final rawDate = profile['tanggal_lahir'];
      if (rawDate != null && rawDate != '') {
        try {
          final parsed = DateTime.parse(rawDate);
          birthDate.value = DateFormat("d MMMM yyyy", "id_ID").format(parsed);
        } catch (_) {
          birthDate.value = '';
        }
        print("💡 Loaded profile: ${profile}");
        print("👤 Username: ${nameController.text}");
        print("📧 Email: ${emailController.text}");
      }
    }
  }

  void pickDate(BuildContext context) async {
    final now = DateTime.now();
    final initial = birthDate.value.isNotEmpty
        ? DateFormat("d MMMM yyyy", "id_ID").parse(birthDate.value)
        : now;

    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1950),
      lastDate: now,
    );

    if (date != null) {
      final formatted = DateFormat("d MMMM yyyy", "id_ID").format(date);
      print("📅 Picked date: $formatted");
      birthDate.value = formatted;
    }
  }

  void saveProfile() async {
    final data = {
      "username": nameController.text.trim(),
      "gender": selectedGender.value,
      "tanggal_lahir": birthDateForBackend,
    };

    final success = await _userService.updateProfile(data);
    if (success) {
      Get.snackbar("Berhasil", "Profil berhasil diperbarui",
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.back();
    } else {
      Get.snackbar("Gagal", "Gagal memperbarui profil",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
