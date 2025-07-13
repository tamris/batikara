import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../data/providers/user_service.dart';
import '../../home/controllers/home_controller.dart';

class EditProfileController extends GetxController {
  final _userService = UserService();
  final picker = ImagePicker();

  final nameController = TextEditingController();
  final emailController = TextEditingController(); // non-editable

  var selectedGender = RxnString(); // bisa null (placeholder)
  var birthDate = ''.obs;
  var profileImage = ''.obs; // bisa dari server atau path lokal

  File? selectedImageFile; // simpan file lokal sementara

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

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      selectedImageFile = File(pickedFile.path); // simpan untuk upload nanti
      profileImage.value = pickedFile.path; // preview di UI
    }
  }

  void loadProfileData() async {
    final profile = await _userService.fetchProfile();
    if (profile != null) {
      profileImage.value = profile['profile_picture'] ?? '';
      nameController.text = profile['username'] ?? '';
      emailController.text = profile['email'] ?? '';

      final gender = profile['gender'];
      selectedGender.value = (gender != null && gender != '') ? gender : null;

      final rawDate = profile['tanggal_lahir'];
      if (rawDate != null && rawDate != '') {
        try {
          final parsed = DateTime.parse(rawDate);
          birthDate.value = DateFormat("d MMMM yyyy", "id_ID").format(parsed);
        } catch (_) {
          birthDate.value = '';
        }
      }

      print("💡 Loaded profile: $profile");
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
      birthDate.value = formatted;
    }
  }

  void saveProfile() async {
    if (selectedGender.value == null) {
      Get.snackbar("Validasi", "Silakan pilih jenis kelamin terlebih dahulu",
          backgroundColor: Colors.orange, colorText: Colors.white);
      return;
    }

    final success = await _userService.updateProfile(
      username: nameController.text.trim(),
      gender: selectedGender.value!,
      tanggalLahir: birthDateForBackend,
      profilePicture: selectedImageFile, // null jika tidak pilih baru
    );

    if (success) {
      final homeController = Get.find<HomeController>();
      homeController.refreshTrigger.toggle();
      Get.snackbar("Berhasil", "Profil berhasil diperbarui",
          backgroundColor: Colors.green, colorText: Colors.white);

      await Future.delayed(Duration(milliseconds: 1000));
      // Get.back(result: true);
    } else {
      Get.snackbar("Gagal", "Gagal memperbarui profil",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
