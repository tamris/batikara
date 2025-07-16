import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/article_model.dart';
import '../../../data/providers/article_service.dart';

class InformasiController extends GetxController {
  final ArticleService _articleService = ArticleService();

  var articles = <Article>[].obs;
  var filteredArticles = <Article>[].obs;

  final searchController = TextEditingController();
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchArticles();

    // Jalankan filter saat searchQuery berubah
    debounce(searchQuery, (_) => filterArticles(), time: Duration(milliseconds: 300));
  }

  void fetchArticles() async {
    try {
      final result = await _articleService.fetchArticles();
      articles.value = result;
      filteredArticles.value = result;
    } catch (e) {
      print('Failed to fetch articles: $e');
    }
  }

  void filterArticles() {
    final query = searchQuery.value.toLowerCase();

    if (query.isEmpty) {
      filteredArticles.value = articles;
    } else {
      filteredArticles.value = articles
          .where((article) =>
              article.title.toLowerCase().contains(query) ||
              article.description.toLowerCase().contains(query))
          .toList();
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
