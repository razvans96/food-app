import 'package:food_app/domain/entities/product_entity.dart';
import 'package:food_app/domain/value_objects/barcode.dart';
import 'package:food_app/shared/results/operation_result.dart';

abstract class ProductRepository {
  Future<Result<ProductEntity>> getProductByBarcode(Barcode barcode);
  Future<Result<List<ProductEntity>>> searchProducts(String query);
}
