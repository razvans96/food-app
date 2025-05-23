import 'package:flutter/material.dart';
import 'package:food_app/models/simple_product.dart';

class UIService {
  static Future<void> showProductDialog(BuildContext context, SimpleProduct product) {
    return showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(product.name ?? 'Producto desconocido'),
        content: Text(product.brands ?? 'Marca desconocida'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
