import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditProfileController extends GetxController {
  final nameController = TextEditingController(text: "Budi Prasetya");
  final emailController = TextEditingController(text: "budiprstya@example.com");

  var selectedGender = "Laki-Laki".obs;
  var birthDate = "".obs;

  void pickDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(2004, 10, 15),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      birthDate.value = DateFormat("d MMMM yyyy", "id_ID").format(date);
    }
  }

  void saveProfile() {
    // Simpan data ke backend atau local storage
    Get.snackbar("Berhasil", "Profil berhasil diperbarui");
  }
}
