import 'package:flutter/material.dart';

class ProductNoResultsMessage extends StatelessWidget {
  const ProductNoResultsMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('No se encontraron resultados.'));
  }
}
