import 'package:flutter/material.dart';
import 'package:food_app/domain/use_cases/search_product_use_case.dart';
import 'package:food_app/presentation/view_models/states/product_search_state.dart';
import 'package:food_app/shared/results/operation_result.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ProductSearchViewModel extends ChangeNotifier {
  final SearchProductsUseCase _searchProductsUseCase;

  ProductSearchViewModel(this._searchProductsUseCase);

  ProductSearchState _state = const ProductSearchState.initial();
  ProductSearchState get state => _state;

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) return;

    _state = const ProductSearchState.loading();
    notifyListeners();

    try {
      final result = await _searchProductsUseCase.execute(query);
      
      _state = result.fold(
        (error) => ProductSearchState.error(
          'Error al buscar productos: $error'),
        (products) => products.isEmpty 
          ? const ProductSearchState.empty()
          : ProductSearchState.success(products),
      );
    } on Exception catch (e) {
      _state = ProductSearchState.error('Error al buscar productos: $e');
    }
    
    notifyListeners();
  }

  void clearResults() {
    _state = const ProductSearchState.initial();
    notifyListeners();
  }
}
