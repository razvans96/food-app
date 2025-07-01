import 'package:flutter/material.dart';
import 'package:food_app/domain/entities/product_entity.dart';
import 'package:food_app/presentation/widgets/product/product_basic_info.dart';
import 'package:food_app/presentation/widgets/product/product_image.dart';
import 'package:food_app/presentation/widgets/product/score/score_helper.dart';
import 'package:food_app/presentation/widgets/product/score/score_row.dart';

class ProductCard extends StatefulWidget {
  final ProductEntity product;
  final bool isExpanded;
  final bool isExpandable;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onExpansionChanged;

  const ProductCard({
    required this.product,
    this.isExpanded = false,
    this.isExpandable = true,
    this.onTap,
    this.onExpansionChanged,
    super.key,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  late AnimationController _animationController;
  late Animation<double> _iconRotation;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _iconRotation = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (_isExpanded) {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    if (!widget.isExpandable) return;

    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (_isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }

    widget.onExpansionChanged?.call(_isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          InkWell(
            onTap: widget.onTap ?? (widget.isExpandable ? _toggleExpansion : null),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductImage(
                        imageUrl: widget.product.imageUrl,
                        size: 80,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ProductBasicInfo(
                          name: widget.product.name,
                          brand: widget.product.brand,
                          quantity: widget.product.quantity,
                        ),
                      ),
                      
                      if (widget.isExpandable)
                        AnimatedBuilder(
                          animation: _iconRotation,
                          builder: (context, child) {
                            return RotationTransition(
                              turns: _iconRotation,
                              child: IconButton(
                                icon: const Icon(Icons.expand_more),
                                onPressed: _toggleExpansion,
                                tooltip: _isExpanded ? 'Contraer' : 'Expandir',
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: _buildExpandedContent(),
            crossFadeState: _isExpanded 
                ? CrossFadeState.showSecond 
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        children: [
          const Divider(height: 1),
          const SizedBox(height: 16),
          
          ScoreRow(
            scoreType: ScoreType.nutriscore,
            scoreValue: widget.product.nutriscoreGrade,
            interpretationText: ScoreHelper.getNutriscoreInterpretation(widget.product.nutriscoreGrade),
          ),
          const SizedBox(height: 8),
          
          ScoreRow(
            scoreType: ScoreType.ecoscore,
            scoreValue: widget.product.ecoscoreGrade,
            interpretationText: ScoreHelper.getEcoscoreInterpretation(widget.product.ecoscoreGrade),
          ),
          const SizedBox(height: 8),
          
          ScoreRow(
            scoreType: ScoreType.nova,
            scoreValue: widget.product.novaGroup?.toString(),
            interpretationText: ScoreHelper.getNovaInterpretation(widget.product.novaGroup),
          ),

          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 12),
        
          _buildDetailsLink(context),
        ],
      ),
    );
  }
  
  Widget _buildDetailsLink(BuildContext context) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () => _navigateToProductDetails(context),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
          ),
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor.withValues(alpha: 0.05),
              Theme.of(context).primaryColor.withValues(alpha: 0.1),
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Consultar información completa',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Icon(
              Icons.arrow_forward,
              size: 18,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    ),
  );
}

  void _navigateToProductDetails(BuildContext context) {
    Navigator.pushNamed(
      context,
      '/product-details',
      arguments: widget.product,
    );
  }
}
