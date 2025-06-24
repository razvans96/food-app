import 'package:flutter/material.dart';
import 'package:food_app/domain/entities/product_entity.dart';
import 'package:food_app/presentation/widgets/product/product_card.dart';

class ProductCardList extends StatelessWidget {
  final List<ProductEntity> products;
  final bool defaultExpanded;
  final bool allowExpansion;
  final void Function(ProductEntity)? onProductTap;
  final ScrollController? scrollController;
  final EdgeInsets? padding;

  const ProductCardList({
    required this.products,
    this.defaultExpanded = false,
    this.allowExpansion = true,
    this.onProductTap,
    this.scrollController,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(
        child: Text(
          'No hay productos para mostrar',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: padding ?? const EdgeInsets.symmetric(vertical: 8),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        
        return ProductCard(
          product: product,
          isExpanded: defaultExpanded,
          isExpandable: allowExpansion,
          onTap: onProductTap != null 
              ? () => onProductTap!(product)
              : null,
        );
      },
    );
  }
}
