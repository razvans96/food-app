import 'package:flutter/material.dart';
import 'package:food_app/presentation/theme/design_constants.dart';
import 'package:food_app/presentation/theme/theme_extensions.dart';
import 'package:food_app/presentation/widgets/shared/cards/empty_state_card.dart';
import 'package:food_app/presentation/widgets/shared/cards/info_card.dart';

class ProductAdditivesList extends StatelessWidget {
  final List<String>? additives;

  const ProductAdditivesList({
    required this.additives,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDesignConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (additives != null && additives!.isNotEmpty) ...[
            _buildAdditivesCard(context),
          ] else
            _buildNoAdditivesCard(context), 
          const SizedBox(height: AppDesignConstants.paddingMedium),
          _buildAdditivesInfo(context),
        ],
      ),
    );
  }

  Widget _buildNoAdditivesCard(BuildContext context) {
    final theme = Theme.of(context);
    final cardColors = theme.productCardColors;
    
    return EmptyStateCard(
      icon: Icons.eco,
      title: 'Sin aditivos declarados',
      description: 'Este producto no contiene aditivos alimentarios identificados',
      backgroundColor: cardColors.successBackground,
      iconColor: cardColors.successBorder,
      textColor: cardColors.successText,
      borderColor: cardColors.successBorder,
    );
  }

  Widget _buildAdditivesCard(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDesignConstants.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.science,
                  color: theme.colorScheme.tertiary,
                  size: AppDesignConstants.iconLarge,
                ),
                const SizedBox(width: AppDesignConstants.paddingSmall),
                Text(
                  'Aditivos Alimentarios (${additives!.length})',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDesignConstants.paddingMedium),
            ...additives!.map((additive) => _buildAdditiveItem(context, additive)),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditiveItem(BuildContext context, String additive) {
    final theme = Theme.of(context);
    final additiveData = _parseAdditive(additive);
    final code = additiveData['code'] ?? 'E000';
    final categoryData = _getAdditiveCategory(context, code);
    
    return Container(
      margin: const EdgeInsets.only(bottom: AppDesignConstants.paddingMedium),
      padding: const EdgeInsets.all(AppDesignConstants.paddingMedium),
      decoration: BoxDecoration(
        color: (categoryData['color'] as Color).withValues(alpha: AppDesignConstants.opacityLight),
        borderRadius: BorderRadius.circular(AppDesignConstants.borderRadiusMedium),
        border: Border.all(
          color: (categoryData['color'] as Color).withValues(alpha: AppDesignConstants.opacityMedium),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDesignConstants.paddingSmall,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: categoryData['color'] as Color,
                  borderRadius: BorderRadius.circular(AppDesignConstants.borderRadiusMedium),
                ),
                child: Text(
                  code,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: (categoryData['color'] as Color).contrastingTextColor,
                  ),
                ),
              ),
              const SizedBox(width: AppDesignConstants.paddingMedium),
              Expanded(
                child: Text(
                  additiveData['name'] ?? additive,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: categoryData['color'] as Color,
                  ),
                ),
              ),
              Icon(
                categoryData['icon'] as IconData,
                color: categoryData['color'] as Color,
                size: AppDesignConstants.iconMedium,
              ),
            ],
          ),
          const SizedBox(height: AppDesignConstants.paddingSmall),
          Row(
            children: [
              Icon(
                Icons.category,
                size: AppDesignConstants.iconSmall,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 6),
              Text(
                categoryData['category'] as String,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            categoryData['description'] as String,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant.withValues(
                alpha: AppDesignConstants.opacityHeavy,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditivesInfo(BuildContext context) {
    final theme = Theme.of(context);
    final cardColors = theme.productCardColors;
    
    return InfoCard(
      title: 'Sobre los aditivos alimentarios',
      icon: Icons.info,
      backgroundColor: cardColors.infoBackground,
      accentColor: cardColors.infoBorder,
      borderColor: cardColors.infoBorder,
      content: Column(
        children: [
          _buildAdditiveCategories(context),
          const SizedBox(height: AppDesignConstants.paddingMedium),
          Text(
            'Todos los aditivos están evaluados y autorizados por la EFSA (Autoridad Europea de Seguridad Alimentaria) y son seguros para el consumo en las dosis establecidas.',
            style: theme.textTheme.bodySmall?.copyWith(
              fontStyle: FontStyle.italic,
              color: cardColors.infoText.withValues(
                alpha: AppDesignConstants.opacityHeavy,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditiveCategories(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        _buildCategoryInfo(
          context, 
          Icons.palette, 
          'E100-E199: Colorantes',
          theme.additiveColors.colorants,
        ),
        _buildCategoryInfo(
          context, 
          Icons.shield, 
          'E200-E299: Conservantes',
          theme.additiveColors.preservatives,
        ),
        _buildCategoryInfo(
          context, 
          Icons.science, 
          'E300-E399: Antioxidantes',
          theme.additiveColors.antioxidants,
        ),
        _buildCategoryInfo(
          context, 
          Icons.texture, 
          'E400-E499: Estabilizantes',
          theme.additiveColors.stabilizers,
        ),
        _buildCategoryInfo(
          context, 
          Icons.blur_on, 
          'E500+: Otros aditivos',
          theme.additiveColors.others,
        ),
      ],
    );
  }

  Widget _buildCategoryInfo(
    BuildContext context, 
    IconData icon, 
    String text,
    Color categoryColor,
  ) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            icon,
            size: 14,
            color: categoryColor,
          ),
          const SizedBox(width: AppDesignConstants.paddingSmall),
          Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, String> _parseAdditive(String additive) {
    final parts = additive.split(' - ');
    if (parts.length >= 2) {
      return {
        'code': parts[0].trim().isNotEmpty ? parts[0].trim() : 'E000',
        'name': parts[1].trim().isNotEmpty ? parts[1].trim() : additive.trim(),
      };
    }
    
    final splitParts = additive.trim().split(' ');
    return {
      'code': splitParts.isNotEmpty ? splitParts[0] : 'E000',
      'name': additive.trim().isNotEmpty ? additive.trim() : 'Aditivo desconocido',
    };
  }

  Map<String, dynamic> _getAdditiveCategory(BuildContext context, String code) {
    final theme = Theme.of(context);
    final additiveColors = theme.additiveColors;
    
    final color = additiveColors.getAdditiveColor(code);
    
    final codeNumber = int.tryParse(code.replaceAll('E', '')) ?? 0;
    
    String category;
    String description;
    IconData icon;
    
    if (codeNumber >= 100 && codeNumber < 200) {
      category = 'Colorante';
      description = 'Proporciona o intensifica el color del alimento';
      icon = Icons.palette;
    } else if (codeNumber >= 200 && codeNumber < 300) {
      category = 'Conservante';
      description = 'Prolonga la vida útil protegiendo contra microorganismos';
      icon = Icons.shield;
    } else if (codeNumber >= 300 && codeNumber < 400) {
      category = 'Antioxidante';
      description = 'Previene la oxidación y el deterioro del producto';
      icon = Icons.science;
    } else if (codeNumber >= 400 && codeNumber < 500) {
      category = 'Estabilizante';
      description = 'Mantiene la textura y consistencia del alimento';
      icon = Icons.texture;
    } else if (codeNumber >= 500 && codeNumber < 600) {
      category = 'Regulador de acidez';
      description = 'Controla y mantiene el nivel de acidez';
      icon = Icons.blur_on;
    } else if (codeNumber >= 600 && codeNumber < 700) {
      category = 'Potenciador del sabor';
      description = 'Realza o modifica el sabor del alimento';
      icon = Icons.restaurant;
    } else if (codeNumber >= 900 && codeNumber < 1000) {
      category = 'Edulcorante';
      description = 'Proporciona sabor dulce con menos calorías';
      icon = Icons.cake;
    } else {
      category = 'Otros aditivos';
      description = 'Aditivo alimentario autorizado';
      icon = Icons.help_outline;
    }

    return {
      'category': category,
      'description': description,
      'color': color,
      'icon': icon,
    };
  }

  
}
