import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

import '../config/app_config.dart';

class UserService {
  final _storage = GetStorage();

  Future<Map<String, dynamic>?> fetchProfile() async {
    final token = _storage.read('token');
    if (token == null) return null;

    final response = await http.get(
      Uri.parse('${AppConfig.baseUrl}/user/profile'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Token: ${_storage.read('token')}");
      print('Failed to fetch profile: ${response.statusCode}');
      return null;
    }
  }

  
}
