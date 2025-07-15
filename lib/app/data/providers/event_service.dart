import 'package:dio/dio.dart';
import '../models/event_model.dart';
import '../config/app_config.dart';

class EventService {
  final Dio _dio = Dio();

  Future<List<EventModel>> fetchEvents() async {
    try {
      final response = await _dio.get('${AppConfig.baseUrl}/api/events');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> eventJson = response.data['data'];
        return eventJson.map((e) => EventModel.fromJson(e)).toList();
      } else {
        throw Exception('Gagal memuat event');
      }
    } on DioError catch (e) {
      throw Exception('Dio error: ${e.message}');
    }
  }
}
