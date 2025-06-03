import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_app/controllers/product_search_controller.dart';
import 'package:food_app/widgets/search_product_bar.dart';
import 'package:food_app/services/product_search_service.dart';
import 'package:food_app/widgets/loading_indicator.dart';
import 'package:food_app/widgets/no_results_message.dart';
import 'package:food_app/widgets/product_list.dart';
import 'package:food_app/widgets/custom_app_bar.dart';

class ProductSearchPage extends StatelessWidget {
  const ProductSearchPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductSearchController(
        productSearchService: ProductSearchService(),
      ),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Buscador de productos'),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Consumer<ProductSearchController>(
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
              Consumer<ProductSearchController>(
                builder: (context, controller, _) {
                  if (controller.isLoading) {
                    return const LoadingIndicator();
                  } else if (controller.searchResults.isEmpty) {
                    return const NoResultsMessage();
                  } else {
                    return ProductList(products: controller.searchResults);
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
