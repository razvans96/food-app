import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:food_app/models/simple_product.dart';
import 'package:food_app/config/config.dart';

class ProductSearchService {
  final String baseUrl = AppConfig.apiBaseUrl;

  ProductSearchService();

  Future<List<SimpleProduct>> searchProducts(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/products?name=$name'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => SimpleProduct.fromJson(json)).toList();
    } else {
      throw Exception('Error al buscar productos: ${response.reasonPhrase}');
    }
  }
}