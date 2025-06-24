import 'package:flutter/material.dart';
import 'package:food_app/presentation/widgets/product/product_search_bar.dart';

class ProductTextSearchBar extends StatelessWidget {

  const ProductTextSearchBar({
    required this.controller, required this.onSearch, super.key,
  });
  final TextEditingController controller;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return ProductSearchBar(
      controller: controller,
      onSearch: onSearch,
      labelText: 'Introduce el término de búsqueda',
    );
  }
}
