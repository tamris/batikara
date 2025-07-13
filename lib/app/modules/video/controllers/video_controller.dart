import 'package:get/get.dart';
import '../../../data/models/video_model.dart';
import '../../../data/providers/video_service.dart';

class VideoController extends GetxController {
  var videoList = <VideoModel>[].obs;
  var filteredList = <VideoModel>[].obs;
  var isLoading = true.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllVideos();
  }

  void fetchAllVideos() async {
    try {
      isLoading(true);
      final result = await VideoService.fetchVideos();
      videoList.assignAll(result);
      filteredList.assignAll(result); // ← awalnya semua
    } catch (e) {
      Get.snackbar("Error", "Gagal mengambil data video");
    } finally {
      isLoading(false);
    }
  }

  void filterVideos(String query) {
    searchQuery.value = query;

    if (query.isEmpty) {
      filteredList.assignAll(videoList);
    } else {
      filteredList.assignAll(
        videoList.where(
          (video) => video.title.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }
}
