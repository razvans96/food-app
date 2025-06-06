import 'package:flutter/material.dart';

class SearchProductBar extends StatelessWidget {

  const SearchProductBar({
    required this.controller, required this.onSearch, super.key,
  });
  final TextEditingController controller;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Buscar productos',
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: const Icon(Icons.search),
          onPressed: onSearch,
        ),
      ),
      onSubmitted: (query) {
        if (query.trim().isNotEmpty) {
          onSearch();
        }
      },
    );
  }
}
