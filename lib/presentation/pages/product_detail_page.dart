import 'package:flutter/material.dart';
import 'package:food_app/domain/entities/product_entity.dart';
import 'package:food_app/presentation/widgets/product/detail/product_additives_list.dart';
import 'package:food_app/presentation/widgets/product/detail/product_allergens_list.dart';
import 'package:food_app/presentation/widgets/product/detail/product_ingredients_list.dart';
import 'package:food_app/presentation/widgets/product/detail/product_nutritional_info.dart';
import 'package:food_app/presentation/widgets/product/product_image.dart';
import 'package:food_app/presentation/widgets/product/score/score_helper.dart';
import 'package:food_app/presentation/widgets/product/score/score_row.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailPage({
    required this.product,
    super.key,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          _buildProductHeader(),
          _buildTabBar(),
          _buildTabContent(),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Información Completa',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withValues(alpha: 0.8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductHeader() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'product-image-${widget.product.barcode.value}',
                      child: ProductImage(
                        imageUrl: widget.product.imageUrl,
                        size: 100,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (widget.product.brand != null)
                            Text(
                              widget.product.brand!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700],
                              ),
                            ),
                          const SizedBox(height: 4),
                          if (widget.product.quantity != null)
                            Text(
                              widget.product.quantity!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          const SizedBox(height: 12),
                          _buildQualityBadges(),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildScoresRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQualityBadges() {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        _buildQualityBadge(
          'Saludable',
          widget.product.isHealthy,
          widget.product.isHealthy ? Colors.green : Colors.orange,
        ),
        _buildQualityBadge(
          'Ecológico',
          widget.product.isEcological,
          widget.product.isEcological ? Colors.green : Colors.orange,
        ),
      ],
    );
  }

  Widget _buildQualityBadge(String label, bool isGood, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isGood ? Icons.check_circle : Icons.warning,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoresRow() {
    return Column(
      children: [
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
      ],
    );
  }

  Widget _buildTabBar() {
    return SliverPersistentHeader(
      delegate: _StickyTabBarDelegate(
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.info_outline), text: 'Nutricional'),
            Tab(icon: Icon(Icons.list_alt), text: 'Ingredientes'),
            Tab(icon: Icon(Icons.warning_amber), text: 'Alérgenos'),
            Tab(icon: Icon(Icons.science), text: 'Aditivos'),
          ],
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: Theme.of(context).primaryColor,
        ),
      ),
      pinned: true,
    );
  }

  Widget _buildTabContent() {
    return SliverFillRemaining(
      child: TabBarView(
        controller: _tabController,
        children: [
          ProductNutritionalInfo(product: widget.product),
          ProductIngredientsList(ingredients: widget.product.ingredients),
          ProductAllergensList(allergens: widget.product.allergens),
          ProductAdditivesList(additives: widget.product.additives),
        ],
      ),
    );
  }
}

// Helper para el TabBar sticky
class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  _StickyTabBarDelegate(this.child);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: child,
    );
  }

  @override
  double get maxExtent => child.preferredSize.height;
  @override
  double get minExtent => child.preferredSize.height;
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
