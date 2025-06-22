import 'package:food_app/domain/entities/product_entity.dart';
import 'package:food_app/domain/repositories/product_repository.dart';
import 'package:food_app/shared/results/operation_result.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class SearchProductsUseCase {
  final ProductRepository _productRepository;

  const SearchProductsUseCase(this._productRepository);

  Future<Result<List<ProductEntity>>> execute(String query) async {
    try {
      final trimmedQuery = query.trim();
      
      if (trimmedQuery.isEmpty) {
        return const Failure('El término de búsqueda no puede estar vacío');
      }
      
      if (trimmedQuery.length < 2) {
        return const Failure('El término de búsqueda debe tener al menos 2 caracteres');
      }
      
      return await _productRepository.searchProducts(trimmedQuery);
    } on Exception catch (e) {
      return Failure('Error inesperado: $e');
    }
  }
}
