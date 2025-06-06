import 'package:flutter/material.dart';
import 'package:food_app/models/product_food.dart';
import 'package:food_app/widgets/product_details.dart';

class UIService {
  static Future<void> showProductDialog(
      BuildContext context, ProductFood product) {
    return showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: ProductDetails(product: product),
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

  static Future<void> showProductBottomSheet(
      BuildContext context, ProductFood product) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => ProductDetails(product: product),
    );
  }
}
