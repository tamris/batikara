import 'package:get/get.dart';
import '../../../data/models/article_model.dart';
import '../../../data/providers/article_service.dart';

class InformasiController extends GetxController {
  final ArticleService _articleService = ArticleService();
  var articles = <Article>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchArticles();
  }

  void fetchArticles() async {
    try {
      final result = await _articleService.fetchArticles();
      articles.value = result;
    } catch (e) {
      print('Failed to fetch articles: $e');
    }
  }
}
