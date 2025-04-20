import 'package:flutter/material.dart';
import 'package:food_app/models/simple_product.dart'; 
import 'package:food_app/services/product_search_service.dart';

class ProductSearchController extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final ProductSearchService productSearchService; // Servicio para buscar productos
  List<SimpleProduct> searchResults = [];
  bool isLoading = false;

  // Constructor que recibe el servicio como parámetro
  ProductSearchController({required this.productSearchService});

  // Método para realizar la búsqueda
  Future<void> searchProducts(String query) async {
    if (query.isEmpty) return;

    isLoading = true;
    notifyListeners(); // Notifica a los listeners que el estado ha cambiado.

    try {
      searchResults = await productSearchService.searchProducts(query); // Llama al servicio
    } catch (e) {
      searchResults = [];
      debugPrint('Error al buscar productos: $e');
    } finally {
      isLoading = false;
      notifyListeners(); // Notifica a los listeners que el estado ha cambiado.
    }
  }

  // Método para limpiar los resultados
  void clearResults() {
    searchResults = [];
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}