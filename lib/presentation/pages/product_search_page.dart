import 'package:flutter/material.dart';
import 'package:food_app/presentation/view_models/product_search_view_model.dart';
import 'package:food_app/presentation/view_models/states/product_search_state.dart';
import 'package:food_app/presentation/widgets/product/product_list.dart';
import 'package:food_app/presentation/widgets/product/product_no_results_message.dart';
import 'package:food_app/presentation/widgets/product/product_text_search_bar.dart';
import 'package:food_app/presentation/widgets/shared/custom_app_bar.dart';
import 'package:food_app/presentation/widgets/shared/loading_indicator.dart';
import 'package:food_app/shared/config/dependency_injection.dart';
import 'package:provider/provider.dart';

class ProductSearchPage extends StatefulWidget {
  const ProductSearchPage({super.key});

  @override
  State<ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  final TextEditingController _searchController = TextEditingController();

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
          padding: const EdgeInsets.all(32),
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
                        child: Text('Busca productos para empezar'),
                      ),
                      Loading() => const LoadingIndicator(),
                      Success(:final products) => ProductList(products: products),
                      Empty() => const ProductNoResultsMessage(),
                      Error(:final message) => Center(
                        child: Text(
                          message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
