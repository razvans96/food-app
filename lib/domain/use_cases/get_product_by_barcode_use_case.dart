
import 'package:food_app/domain/entities/product_entity.dart';
import 'package:food_app/domain/failures/domain_failures.dart';
import 'package:food_app/domain/repositories/product_repository.dart';
import 'package:food_app/domain/value_objects/barcode.dart';
import 'package:food_app/shared/results/operation_result.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetProductByBarcodeUseCase {
  final ProductRepository _productRepository;

  const GetProductByBarcodeUseCase(this._productRepository);

  Future<Result<ProductEntity>> execute(String barcodeString) async {
    try {
      final barcode = Barcode(barcodeString);
      return await _productRepository.getProductByBarcode(barcode);
    } on DomainFailure catch (e) {
      return Failure('Código de barras inválido: ${e.message}');
    } on Exception catch (e) {
      return Failure('Error inesperado: $e');
    }
  }
}
