// view/gallery_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/galery_controller.dart';

class GalleryView extends GetView<GalleryController> {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Batik Tegalan'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  hintText: 'Search',
                ),
                onChanged: controller.search,
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              final filteredItems = controller.filteredItems;
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.thumb_up_alt_outlined, size: 16),
                          SizedBox(width: 8),
                          Icon(Icons.comment_outlined, size: 16),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(item, style: const TextStyle(fontSize: 14)),
                    ],
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
