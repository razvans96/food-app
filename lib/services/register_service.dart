import 'package:http/http.dart' as http;
import 'package:food_app/config/config.dart';

class RegisterService {
  
  final String baseUrl = AppConfig.apiBaseUrl;

  Future<void> registerUser({
    required String userId,
    required String name,
    required String surname,
    required String phone,
    required String dob,
  }) async {

    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: {
        'userId': userId,
        'name': name,
        'surname': surname,
        'phone': phone,
        'dob': dob,
      }.toString(),
    );
    
    if (response.statusCode != 200) {
      throw Exception('Failed to register user: ${response.body}');
    }
  }
}