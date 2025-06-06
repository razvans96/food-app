import 'package:flutter/material.dart';
import 'package:food_app/models/simple_product.dart';

class ProductList extends StatelessWidget {

  const ProductList({required this.products, super.key});
  
  final List<SimpleProduct> products;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name ?? 'Producto desconocido'),
            subtitle: Text(product.brands ?? 'Marca desconocida'),
          );
        },
      ),
    );
  }
}
