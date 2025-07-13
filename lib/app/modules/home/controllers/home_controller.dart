import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/models/article_model.dart';
import '../../../data/providers/article_service.dart';
import '../../../data/providers/user_service.dart';

class HomeController extends GetxController {
  var username = ''.obs;
  var greeting = ''.obs;
  var profileImage = ''.obs;
  var articles = <Article>[].obs;

  final ArticleService _articleService = ArticleService();
  final UserService _userService = UserService();
  final box = GetStorage();
  final refreshTrigger = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadGreeting();
    loadUserProfile();
    loadArticles();

    ever(refreshTrigger, (_) {
      loadUserProfile();
    });
  }

  void loadGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 11) {
      greeting.value = "Sugeng Enjing";
    } else if (hour < 15) {
      greeting.value = "Sugeng Siang";
    } else if (hour < 18) {
      greeting.value = "Sugeng Sonten";
    } else {
      greeting.value = "Sugeng Dalu";
    }
  }

  void loadUserProfile() async {
    final profile = await _userService.fetchProfile();
    if (profile != null) {
      final name = profile['username'] ?? 'User';
      final image = profile['profile_picture'] ?? '';

      username.value = name;
      profileImage.value = image;

      // Optional: simpan ke storage kalau mau dipakai di tempat lain
      box.write('username', name);
      box.write('profile_picture', image);

      print("📦 FULL PROFILE DATA: $profile");

      print("✅ Profile loaded: $name");
    } else {
      print("❌ Gagal ambil profile");
    }
  }

  void loadArticles() async {
    try {
      final fetched = await _articleService.fetchArticles();
      articles.value = fetched.take(2).toList();
    } catch (e) {
      print("❌ Error fetching articles: $e");
    }
  }
}
