import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:food_app/models/simple_product.dart';

class FoodApiService {
  final String baseUrl;

  FoodApiService({this.baseUrl = 'http://localhost:8080'});

  // Método para buscar productos por nombre
  Future<List<SimpleProduct>> searchProducts(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/product?name=$name'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> products = data['products'];
      return products.map((json) => SimpleProduct.fromJson(json)).toList();
    } else {
      throw Exception('Error al buscar productos: ${response.reasonPhrase}');
    }
  }

  // Método para obtener un producto por código de barras
  Future<SimpleProduct> getProduct(String barcode) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$barcode'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      // Convierte el JSON en un SimpleProduct
      return SimpleProduct.fromJson(data);
    } else {
      throw Exception('Error al obtener el producto: ${response.reasonPhrase}');
    }
  }
}