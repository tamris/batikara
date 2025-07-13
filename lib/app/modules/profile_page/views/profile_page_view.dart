import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sibatikgal/app/modules/profile_page/controllers/profile_page_controller.dart';
import '../../../data/config/app_config.dart';

class ProfilePageView extends GetView<ProfilePageController> {
  const ProfilePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDA7137), // Background coklat
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Obx(() => CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage: controller.profileImage.isEmpty
                        ? const AssetImage('assets/icons/avatar.png')
                        : NetworkImage(
                                '${AppConfig.baseUrl}${controller.profileImage}')
                            as ImageProvider,
                  )),
              const SizedBox(height: 18),
              Obx(() => Text(
                    controller.name.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  )),
              const SizedBox(height: 4),
              Obx(() => Text(
                    controller.email.value,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                    ),
                  )),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: () async {
                  final result = await Get.toNamed('/edit-profile');
                  if (result == true) {
                    controller.fetchProfile(); // 🔁 refresh data
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text(
                  'Edit Profil',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildMenuItem(Icons.history, "Riwayat Pengenalan Batik",
                        controller.goToHistory),
                    _buildDivider(),
                    _buildMenuItem(
                        Icons.favorite, "Favorit", controller.goToFavorite),
                    _buildDivider(),
                    _buildMenuItem(Icons.manage_history, "Riwayat Login",
                        controller.goToHistoryLogin),
                    _buildDivider(),
                    _buildMenuItem(
                        Icons.security, "Keamanan", controller.goToSecurity),
                    _buildDivider(),
                    _buildMenuItem(
                        Icons.info, "Tentang Aplikasi", controller.goToAbout),
                    _buildDivider(),
                    _buildMenuItem(Icons.logout, "LogOut", controller.logout),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      color: Colors.black26,
      indent: 16,
      endIndent: 16,
    );
  }
}
