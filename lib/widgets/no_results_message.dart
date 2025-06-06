import 'package:flutter/material.dart';

class NoResultsMessage extends StatelessWidget {
  const NoResultsMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('No se encontraron resultados.'));
  }
}
