import 'package:flutter/material.dart';
import 'package:food_app/presentation/view_models/product_query_view_model.dart';
import 'package:food_app/presentation/view_models/states/product_query_state.dart';
import 'package:food_app/presentation/widgets/product/product_barcode_scanner_button.dart';
import 'package:food_app/presentation/widgets/product/product_barcode_search_bar.dart';
import 'package:food_app/presentation/widgets/product/product_card.dart';
import 'package:food_app/presentation/widgets/shared/custom_app_bar.dart';
import 'package:food_app/presentation/widgets/shared/custom_bottom_navigation_bar.dart';
import 'package:food_app/presentation/widgets/shared/welcome_view.dart';
import 'package:food_app/shared/config/dependency_injection.dart';
import 'package:provider/provider.dart';

enum InputMethod { scanner, manual }

class ProductQueryPage extends StatefulWidget {
  const ProductQueryPage({super.key});

  @override
  State<ProductQueryPage> createState() => _ProductQueryPageState();
}

class _ProductQueryPageState extends State<ProductQueryPage> {
  final TextEditingController _searchController = TextEditingController();
  
  InputMethod _selectedInputMethod = InputMethod.scanner;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(ProductQueryViewModel viewModel) {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      FocusScope.of(context).unfocus();
      viewModel.fetchProduct(query);
    }
  }

  Future<void> _onBarcodeScanned(ProductQueryViewModel viewModel, String? code) async {
    if (code != null && code.trim() != '-1') {
      _searchController.text = code;
      FocusScope.of(context).unfocus();
      await viewModel.fetchProduct(code);
    }
  }

  Widget _buildInputMethodToggle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: SegmentedButton<InputMethod>(
        segments: const [
          ButtonSegment<InputMethod>(
            value: InputMethod.scanner,
            label: Text('Escáner'),
          ),
          ButtonSegment<InputMethod>(
            value: InputMethod.manual,
            label: Text('Teclado'),
          ),
        ],
        selected: <InputMethod>{_selectedInputMethod},
        onSelectionChanged: (Set<InputMethod> newSelection) {
          setState(() {
            _selectedInputMethod = newSelection.first;
          });
          FocusScope.of(context).unfocus();
        },
        style: SegmentedButton.styleFrom(
          selectedBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
          selectedForegroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }

  Widget _buildTextFieldArea(ProductQueryViewModel viewModel) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: _selectedInputMethod == InputMethod.manual ? null : 0,
      child: _selectedInputMethod == InputMethod.manual
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ProductBarcodeSearchBar(
                controller: _searchController,
                onSearch: () => _onSearch(viewModel),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildScannerButton(ProductQueryViewModel viewModel) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: _selectedInputMethod == InputMethod.scanner ? null : 0,
      child: _selectedInputMethod == InputMethod.scanner
          ? Container(
              padding: const EdgeInsets.all(16),
              child: ProductBarcodeScannerButton(
                onScanned: (code) => _onBarcodeScanned(viewModel, code),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildMainContent(ProductQueryViewModel viewModel) {
    return Expanded(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: switch (viewModel.state) {
            Initial() => const WelcomeView(),
            Loading() => const CircularProgressIndicator(),
            Success(:final product) => ProductCard(
              product: product,
              isExpanded: true,
              isExpandable: false,
            ),
            Error(:final message) => Text(
              message,
              style: const TextStyle(color: Colors.red),
            ),
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: getIt<ProductQueryViewModel>(),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Consulta de Productos'),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Consumer<ProductQueryViewModel>(
            builder: (context, viewModel, _) {
              return Column(
                children: [
                  _buildInputMethodToggle(),  
                  _buildTextFieldArea(viewModel),
                  _buildMainContent(viewModel),
                  _buildScannerButton(viewModel),
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(),
      ),
    );
  }
}
