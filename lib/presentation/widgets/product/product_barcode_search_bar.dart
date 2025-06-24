import 'package:flutter/material.dart';
import 'package:food_app/presentation/widgets/product/product_search_bar.dart';

class ProductBarcodeSearchBar extends StatelessWidget {
  const ProductBarcodeSearchBar({
    required this.controller,
    required this.onSearch,
    super.key,
  });

  final TextEditingController controller;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return ProductSearchBar(
      controller: controller,
      onSearch: onSearch,
      inputType: SearchInputType.numeric,
    );
  }
}
