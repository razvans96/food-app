import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:food_app/models/simple_product.dart';
import 'package:food_app/config/config.dart';

class ProductQueryService {

  final String baseUrl = AppConfig.apiBaseUrl;
  
  ProductQueryService();

  Future<SimpleProduct> getProduct(String barcode) async {
    final response = await http.get(Uri.parse('$baseUrl/product/$barcode'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return SimpleProduct.fromJson(data);
    } else {
      throw Exception('Error al obtener el producto: ${response.reasonPhrase}');
    }
  }
}