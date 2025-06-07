import 'dart:convert';
import 'package:food_app/client/custom_http_client.dart';
import 'package:food_app/config/config.dart';
import 'package:food_app/models/product_food.dart';



class ProductQueryService {
  ProductQueryService();


  final String baseUrl = AppConfig.apiBaseUrl;
  final _http = CustomHttpClient();

  Future<ProductFood> getProduct(String barcode) async {
    final response = await _http.get(Uri.parse('$baseUrl/product/$barcode'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return ProductFood.fromJson(data);
    } else {
      throw Exception('Error al obtener el producto: ${response.reasonPhrase}');
    }
  }
}
