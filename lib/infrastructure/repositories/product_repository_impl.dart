import 'dart:convert';

import 'package:food_app/application/dto/api_response_dto.dart';
import 'package:food_app/application/dto/product_response_dto.dart';
import 'package:food_app/domain/entities/product_entity.dart';
import 'package:food_app/domain/repositories/product_repository.dart';
import 'package:food_app/domain/value_objects/barcode.dart';
import 'package:food_app/shared/config/config.dart';
import 'package:food_app/shared/results/operation_result.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final String baseUrl = AppConfig.apiBaseUrl;

  @override
  Future<Result<ProductEntity>> getProductByBarcode(Barcode barcode) async {
    try {
      final url = Uri.parse('$baseUrl/product/${barcode.value}');
      
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final apiResponse = ApiResponse<ProductResponseDto>.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
          (json) => ProductResponseDto.fromJson(json! as Map<String, dynamic>),
        );
        
        if (apiResponse.success && apiResponse.data != null) {
          return Success(
            apiResponse.message,
            apiResponse.data!.toDomain(),
          );
        } else {
          return Failure(apiResponse.error ?? 'Error al obtener producto');
        }
      } else if (response.statusCode == 404) {
        return const Failure('Producto no encontrado');
      } else {
        return Failure(
          'Error HTTP ${response.statusCode}: ${response.reasonPhrase}');
      }
    } on Exception catch (e) {
      return Failure('Error de conexión: $e');
    }
  }

  @override
  Future<Result<List<ProductEntity>>> searchProducts(String query) async {
    try {
      final url = Uri.parse('$baseUrl/product').replace(
        queryParameters: {'q': query},
      );
      
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final apiResponse = ApiResponse<List<ProductResponseDto>>.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
          (json) => (json! as List<dynamic>)
              .map((item) => ProductResponseDto.fromJson(item as Map<String, dynamic>))
              .toList(),
        );
        
        if (apiResponse.success && apiResponse.data != null) {
          final products = apiResponse.data!
              .map((dto) => dto.toDomain())
              .toList();
              
          return Success(
            apiResponse.message,
            products,
          );
        } else {
          return Failure(apiResponse.error ?? 'Error al buscar productos');
        }
      } else if (response.statusCode == 404) {
        return const Success('No se encontraron productos', <ProductEntity>[]);
      } else {
        return Failure('Error HTTP ${response.statusCode}: ${response.reasonPhrase}');
      }
    } on Exception catch (e) {
      return Failure('Error de conexión: $e');
    }
  }
}
