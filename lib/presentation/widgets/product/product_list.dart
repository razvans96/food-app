import 'package:flutter/material.dart';
import 'package:food_app/domain/entities/product_entity.dart';

class ProductList extends StatelessWidget {
  final List<ProductEntity> products;

  const ProductList({
    required this.products, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              leading: product.imageUrl!.isNotEmpty
                  ? Image.network(
                      product.imageUrl!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image_not_supported);
                      },
                    )
                  : const Icon(Icons.image_not_supported),
              title: Text(
                product.name.isNotEmpty ? product.name : 'Producto sin nombre',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.brand!.isNotEmpty)
                    Text('Marca: ${product.brand}'),
                  if (product.nutriscoreGrade!.isNotEmpty)
                    Text('NutriScore: ${product.nutriscoreGrade!.toUpperCase()}'),
                ],
              ),
              onTap: () {
                // TODO: Navegar a detalles del producto
                // Navigator.push(context, MaterialPageRoute(
                //   builder: (context) => ProductDetailsPage(product: product),
                // ));
              },
            ),
          );
        },
      ),
    );
  }
}
