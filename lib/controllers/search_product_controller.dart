import 'package:flutter/material.dart';
import 'package:food_app/services/food_api_service.dart';
import 'package:food_app/models/simple_product.dart'; 

class SearchProductController extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final FoodApiService foodApiService;
  List<SimpleProduct> searchResults = [];
  bool isLoading = false;

  // Constructor que recibe el servicio como parámetro
  SearchProductController({required this.foodApiService});

  // Método para realizar la búsqueda
  Future<void> searchProducts(String query) async {
    if (query.isEmpty) return;

    isLoading = true;
    notifyListeners(); // Notifica a los listeners que el estado ha cambiado.

    try {
      searchResults = await foodApiService.searchProducts(query); // Llama al servicio
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