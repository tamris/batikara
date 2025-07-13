import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/config/app_config.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditProfileController>();

    return Scaffold(
      backgroundColor: const Color(0xFFDA7137),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDA7137),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(result: true), // ✅ ini penting
        ),
        title: const Text(
          "Edit Profil",
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Obx(() => Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: controller
                                    .profileImage.value.isEmpty
                                ? const AssetImage("assets/icons/avatar.png")
                                : controller.profileImage.value
                                        .startsWith("/data")
                                    ? FileImage(
                                        File(controller.profileImage.value))
                                    : NetworkImage(
                                            '${AppConfig.baseUrl}${controller.profileImage.value}')
                                        as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 4,
                            child: GestureDetector(
                              onTap: () =>
                                  _showImageSourceOptions(context, controller),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                                padding: const EdgeInsets.all(6),
                                child: const Icon(Icons.camera_alt,
                                    color: Colors.white, size: 20),
                              ),
                            ),
                          )
                        ],
                      )),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            const SizedBox(height: 24),
            buildTextField("Username", controller.nameController, true),
            buildTextField("Email", controller.emailController, false),
            buildDropdown(controller),
            buildDatePicker(context, controller),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: controller.saveProfile,
              child: const Text(
                "Simpan",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
      String label, TextEditingController controller, bool editable) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              )),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            enabled: editable,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdown(EditProfileController controller) {
    final genderOptions = ['Laki-Laki', 'Perempuan'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Jenis Kelamin",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              )),
          const SizedBox(height: 6),
          Obx(() => DropdownButtonFormField<String>(
                value: genderOptions.contains(controller.selectedGender.value)
                    ? controller.selectedGender.value
                    : null, // ⬅️ null biar placeholder muncul
                hint: const Text("Pilih jenis kelamin"), // ⬅️ Placeholder-nya
                items: genderOptions
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => controller.selectedGender.value = val,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget buildDatePicker(
      BuildContext context, EditProfileController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Tanggal Lahir",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              )),
          const SizedBox(height: 6),
          InkWell(
            onTap: () => controller.pickDate(context),
            child: Obx(() => InputDecorator(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    controller.birthDate.value.isEmpty
                        ? "Pilih tanggal"
                        : controller.birthDate.value,
                    style: TextStyle(
                      color: controller.birthDate.value.isEmpty
                          ? Colors.grey
                          : Colors.black,
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  void _showImageSourceOptions(
      BuildContext context, EditProfileController controller) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Pilih dari Galeri"),
                onTap: () {
                  Navigator.pop(context);
                  controller.pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Ambil dari Kamera"),
                onTap: () {
                  Navigator.pop(context);
                  controller.pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
