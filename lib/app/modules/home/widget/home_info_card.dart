import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sibatikgal/app/data/config/app_config.dart';
import 'package:sibatikgal/app/data/models/article_model.dart';
import 'package:sibatikgal/app/modules/informasi/views/detail_informasi_view.dart';

class HomeInfoCard extends StatelessWidget {
  final Article article;
  final Widget imageWidget;

  const HomeInfoCard({
    Key? key,
    required this.article,
    required this.imageWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar dinamis (network atau asset)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 130,
              width: double.infinity,
              child: imageWidget,
            ),
          ),
          const SizedBox(height: 10),

          // Judul
          Text(
            article.title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const Spacer(),

          // Tombol Detail
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Get.to(() => DetailInformasiView(
                      title: article.title,
                      imageUrl: '${AppConfig.baseUrl}${article.imageUrl}',
                      description: article.description,
                      date: article.createdAt,
                    ));
              },
              child: const Text(
                "Detail >",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
