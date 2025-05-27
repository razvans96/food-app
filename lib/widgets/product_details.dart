import 'package:flutter/material.dart';
import 'package:food_app/models/product_food.dart';

class ProductDetails extends StatelessWidget {
  final ProductFood product;

  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name ?? 'Producto desconocido',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (product.imageUrl != null && product.imageUrl!.isNotEmpty)
                Image.network(
                  product.imageUrl!,
                  height: 120,
                  fit: BoxFit.cover,
                )
              else
                Container(
                  height: 120,
                  width: 120,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported, size: 48, color: Colors.grey),
                ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Marca: ${product.brand ?? 'Desconocida'}'),
                    Text('Cantidad: ${product.quantity ?? 'Desconocida'}'),
                    Text('NutriScore: ${product.nutriscoreGrade ?? 'Desconocido'}'),
                    Text('Ecoscore: ${product.ecoscoreGrade ?? 'Desconocido'}'),
                    Text('Nova: ${product.novaGroup ?? 'Desconocido'}'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
