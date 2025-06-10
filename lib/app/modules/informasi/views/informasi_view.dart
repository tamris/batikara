import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sibatikgal/app/data/config/app_config.dart';
import 'package:sibatikgal/app/modules/informasi/controllers/informasi_controller.dart';
import 'package:sibatikgal/app/modules/informasi/views/detail_informasi_view.dart';

class InformasiView extends GetView<InformasiController> {
  const InformasiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: Get.back,
        ),
        title: const Text(
          'Informasi',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.articles.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  itemCount: controller.articles.length,
                  itemBuilder: (context, index) {
                    final article = controller.articles[index];
                    return _buildInformasiCard(article);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInformasiCard(article) {
    final imageUrl =
        '${AppConfig.baseUrl}/${article.imageUrl.replaceFirst(RegExp(r"^/"), "")}';

    return GestureDetector(
      onTap: () {
        Get.to(() => DetailInformasiView(
              title: article.title,
              imageUrl: imageUrl,
              description: article.description,
              date: article.createdAt,
            ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/img/placeholder.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 150,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    article.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontFamily: 'Poppins',
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
