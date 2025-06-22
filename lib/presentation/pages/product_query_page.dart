import 'package:flutter/material.dart';
import 'package:food_app/presentation/view_models/product_query_view_model.dart';
import 'package:food_app/presentation/view_models/states/product_query_state.dart';
import 'package:food_app/presentation/widgets/barcode/barcode_scanner_button.dart';
import 'package:food_app/presentation/widgets/product/product_barcode_search_bar.dart';
import 'package:food_app/presentation/widgets/product/product_details.dart';
import 'package:food_app/presentation/widgets/shared/custom_app_bar.dart';
import 'package:food_app/presentation/widgets/shared/welcome_view.dart';
import 'package:food_app/shared/config/dependency_injection.dart';
import 'package:provider/provider.dart';


class ProductQueryPage extends StatefulWidget {
  const ProductQueryPage({super.key});

  @override
  State<ProductQueryPage> createState() => _ProductQueryPageState();
}

class _ProductQueryPageState extends State<ProductQueryPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(ProductQueryViewModel viewModel) {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      viewModel.fetchProduct(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: getIt<ProductQueryViewModel>(),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Escáner'),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Consumer<ProductQueryViewModel>(
                builder: (context, viewModel, _) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProductBarcodeSearchBar(
                        controller: _searchController,
                        onSearch: () => _onSearch(viewModel),
                      ),
                      const SizedBox(height: 24),
                      BarcodeScannerButton(
                        onScanned: (code) async {
                          if (code != null && code.trim() != '-1') {
                            await viewModel.fetchProduct(code);
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                      
                      switch (viewModel.state) {
                        Initial() => const WelcomeView(),
                        Loading() => const CircularProgressIndicator(),
                        Success(:final product) => ProductDetails(product: product),
                        Error(:final message) => Text(
                          message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      }
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
