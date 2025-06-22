import 'package:flutter/material.dart';
import 'package:food_app/domain/use_cases/get_product_by_barcode_use_case.dart';
import 'package:food_app/presentation/view_models/states/product_query_state.dart';
import 'package:food_app/shared/results/operation_result.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ProductQueryViewModel extends ChangeNotifier {
  final GetProductByBarcodeUseCase _getProductByBarcodeUseCase;

  ProductQueryViewModel(this._getProductByBarcodeUseCase);

  ProductQueryState _state = const ProductQueryState.initial();
  ProductQueryState get state => _state;

  Future<void> fetchProduct(String code) async {
    _state = const ProductQueryState.loading();
    notifyListeners();

    try {
      final result = await _getProductByBarcodeUseCase.execute(code);
      
      _state = result.fold(
        (error) => ProductQueryState.error(
          'Error al obtener el producto: $error'),
        ProductQueryState.success,
      );
    } on Exception catch (e) {
      _state = ProductQueryState.error('Error al obtener el producto: $e');
    }
    
    notifyListeners();
  }

  void clearState() {
    _state = const ProductQueryState.initial();
    notifyListeners();
  }
}
