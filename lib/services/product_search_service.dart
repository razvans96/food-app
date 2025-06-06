import 'dart:convert';
import 'package:food_app/config/config.dart';
import 'package:food_app/models/simple_product.dart';
import 'package:http/http.dart' as http;

class ProductSearchService {

  ProductSearchService();

  final String baseUrl = AppConfig.apiBaseUrl;

  Future<List<SimpleProduct>> searchProducts(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/product?name=$name'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final products = data['products'] as List<dynamic>;
      return products.map((item) => 
        SimpleProduct.fromJson(item as Map<String, dynamic>)).toList();

    } else {
      throw Exception('Error al buscar productos: ${response.reasonPhrase}');
    }
  }
}
