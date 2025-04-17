import 'package:flutter/material.dart';

class SearchProductBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;

  const SearchProductBar({
    super.key,
    required this.controller,
    required this.onSearch,
  });
  

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Buscar productos',
        border: OutlineInputBorder(),
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