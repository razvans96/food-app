import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_app/controllers/search_product_controller.dart';
import 'widgets/search_product_bar.dart';
import 'package:food_app/services/food_api_service.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchProductController( 
        foodApiService: FoodApiService(), // Proporciona el servicio 
      ), // Proporciona el controlador a la vista.
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Consumer<SearchProductController>(
                builder: (context, controller, _) {
                  return SearchProductBar(
                    controller: controller.searchController,
                    onSearch: () {
                      final query = controller.searchController.text.trim();
                      if (query.isNotEmpty) {
                        controller.searchProducts(query);
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              Consumer<SearchProductController>(
                builder: (context, controller, _) {
                  if (controller.isLoading) {
                    return const CircularProgressIndicator();
                  } else if (controller.searchResults.isEmpty) {
                    return const Text('No se encontraron resultados.');
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: controller.searchResults.length,
                        itemBuilder: (context, index) {
                          final product = controller.searchResults[index];
                          return ListTile(
                            title: Text(product.name ?? 'Producto desconocido'),
                            subtitle: Text(product.brands ?? 'Marca desconocida'),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}