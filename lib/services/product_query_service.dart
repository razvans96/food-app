import 'dart:convert';

import 'package:food_app/config/config.dart';
import 'package:food_app/models/product_food.dart';
import 'package:http/http.dart' as http;

class ProductQueryService {

  ProductQueryService();
  
  final String baseUrl = AppConfig.apiBaseUrl;

  Future<ProductFood> getProduct(String barcode) async {
    final response = await http.get(Uri.parse('$baseUrl/product/$barcode'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return ProductFood.fromJson(data);
    } else {
      throw Exception('Error al obtener el producto: ${response.reasonPhrase}');
    }
  }
}
