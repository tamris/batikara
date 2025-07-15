import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sibatikgal/app/data/models/event_model.dart';
import '../../../data/providers/event_service.dart';

class EventController extends GetxController {
  final events = <EventModel>[].obs;
  final isLoading = false.obs;

  final EventService _service = EventService();

  @override
  void onInit() {
    fetchAllEvents();
    super.onInit();
  }

  void fetchAllEvents() async {
    try {
      isLoading.value = true;
      final fetchedEvents = await _service.fetchEvents();
      events.assignAll(fetchedEvents);
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat event: $e');
    } finally {
      isLoading.value = false;
    }
  }

  String formatTanggalIndo(String rawDate) {
    try {
      final DateTime parsedDate = DateTime.parse(rawDate);
      return DateFormat('dd MMMM yyyy', 'id_ID').format(parsedDate);
    } catch (_) {
      return rawDate; // fallback
    }
  }
}
