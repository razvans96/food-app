import 'dart:convert';

import 'package:food_app/config/config.dart';
import 'package:food_app/models/user.dart';
import 'package:http/http.dart' as http;

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
      var errorMsg = 'Failed to register user';
      try {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        if (body.containsKey('error')) {
          errorMsg = body['error'].toString();
        }
      } on Exception catch (e) {
        errorMsg = 'Error parsing error message: $e';
      }
      throw Exception(errorMsg);
    }
  }
}
