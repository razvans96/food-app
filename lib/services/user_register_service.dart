import 'package:http/http.dart' as http;
import 'package:food_app/config/config.dart';
import 'package:food_app/models/user.dart';
import 'dart:convert';

class UserRegisterService {
  final String baseUrl = AppConfig.apiBaseUrl;

  Future<void> registerUser(AppUser user) async {
    final url = Uri.parse('$baseUrl/user');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode != 200) {
      String errorMsg = 'Failed to register user';
      try {
        final Map<String, dynamic> body = jsonDecode(response.body);
        if (body.containsKey('error')) {
          errorMsg = body['error'].toString();
        }
      } catch (_) {
        
      }
      throw Exception(errorMsg);
    }
  }
}