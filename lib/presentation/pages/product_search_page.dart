import 'package:flutter/material.dart';
import 'package:food_app/domain/entities/product_entity.dart';
import 'package:food_app/presentation/view_models/product_search_view_model.dart';
import 'package:food_app/presentation/view_models/states/product_search_state.dart';
import 'package:food_app/presentation/widgets/product/product_card_list.dart';
import 'package:food_app/presentation/widgets/product/product_no_results_message.dart';
import 'package:food_app/presentation/widgets/product/product_text_search_bar.dart';
import 'package:food_app/presentation/widgets/shared/custom_app_bar.dart';
import 'package:food_app/presentation/widgets/shared/custom_bottom_navigation_bar.dart';
import 'package:food_app/presentation/widgets/shared/custom_loading_indicator.dart';
import 'package:food_app/shared/config/dependency_injection.dart';
import 'package:provider/provider.dart';

class ProductSearchPage extends StatefulWidget {
  const ProductSearchPage({super.key});

  @override
  State<ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  final TextEditingController _searchController = TextEditingController();

  void _onProductSelected(ProductEntity product) {
    // TODO: Navegar a detalles del producto??
    debugPrint('Producto seleccionado: ${product.name}');
    
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: getIt<ProductSearchViewModel>(),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Buscador de productos'),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Consumer<ProductSearchViewModel>(
                builder: (context, viewModel, _) {
                  return ProductTextSearchBar(
                    controller: _searchController,
                    onSearch: () {
                      final query = _searchController.text.trim();
                      if (query.isNotEmpty) {
                        viewModel.searchProducts(query);
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Consumer<ProductSearchViewModel>(
                  builder: (context, viewModel, _) {
                    return switch (viewModel.state) {
                      Initial() => const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Busca entre millones de productos',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Loading() => const CustomLoadingIndicator(),
                      Success(:final products) => ProductCardList(
                        products: products,
                        onProductTap: _onProductSelected,
                      ),
                      Empty() => const ProductNoResultsMessage(),
                      Error(:final message) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              message,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(),
      ),
    );
  }
}
