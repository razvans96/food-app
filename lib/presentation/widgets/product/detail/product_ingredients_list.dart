import 'package:flutter/material.dart';
import 'package:food_app/presentation/theme/design_constants.dart';
import 'package:food_app/presentation/theme/theme_extensions.dart';
import 'package:food_app/presentation/widgets/shared/cards/empty_state_card.dart';
import 'package:food_app/presentation/widgets/shared/cards/info_card.dart';

class ProductIngredientsList extends StatelessWidget {
  final List<String>? ingredients;

  const ProductIngredientsList({
    required this.ingredients,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (ingredients == null || ingredients!.isEmpty) {
      return _buildNoDataCard(context);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDesignConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIngredientsCard(context),
          const SizedBox(height: AppDesignConstants.paddingMedium),
          _buildIngredientsInfo(context),
        ],
      ),
    );
  }

  Widget _buildNoDataCard(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(AppDesignConstants.paddingMedium),
        child: EmptyStateCard(
          icon: Icons.list_alt,
          title: 'Lista de ingredientes no disponible',
          description: 'No se encontró información sobre los ingredientes de este producto',
        ),
      ),
    );
  }

  Widget _buildIngredientsCard(BuildContext context) {
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
                  Icons.eco,
                  color: theme.colorScheme.primary,
                  size: AppDesignConstants.iconLarge,
                ),
                const SizedBox(width: AppDesignConstants.paddingSmall),
                Text(
                  'Ingredientes (${ingredients!.length})',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDesignConstants.paddingMedium),
            _buildIngredientsGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientsGrid(BuildContext context) {
    return Wrap(
      spacing: AppDesignConstants.paddingSmall,
      runSpacing: AppDesignConstants.paddingSmall,
      children: ingredients!.asMap().entries.map((entry) {
        final index = entry.key;
        final ingredient = entry.value;
        return _buildIngredientChip(context, ingredient, index);
      }).toList(),
    );
  }

  Widget _buildIngredientChip(BuildContext context, String ingredient, int index) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // Los primeros ingredientes son más importantes (mayor cantidad)
    final isMainIngredient = index < 5;
    final isPrimaryIngredient = index < 3;
    
    Color backgroundColor;
    Color textColor;
    Color borderColor;
    
    if (isPrimaryIngredient) {
      backgroundColor = colorScheme.primaryContainer.withValues(alpha: AppDesignConstants.opacityMedium);
      textColor = colorScheme.onPrimaryContainer;
      borderColor = colorScheme.primary.withValues(alpha: AppDesignConstants.opacityMedium);
    } else if (isMainIngredient) {
      backgroundColor = colorScheme.secondaryContainer.withValues(alpha: AppDesignConstants.opacityLight);
      textColor = colorScheme.onSecondaryContainer;
      borderColor = colorScheme.secondary.withValues(alpha: AppDesignConstants.opacityMedium);
    } else {
      backgroundColor = colorScheme.surfaceContainerHighest.withValues(alpha: AppDesignConstants.opacityLight);
      textColor = colorScheme.onSurface;
      borderColor = colorScheme.outline.withValues(alpha: AppDesignConstants.opacityMedium);
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDesignConstants.paddingMedium, 
        vertical: AppDesignConstants.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppDesignConstants.borderRadiusLarge),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isPrimaryIngredient)
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.only(right: 6),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
          Text(
            ingredient,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 13,
              fontWeight: isPrimaryIngredient ? FontWeight.w600 : FontWeight.w500,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientsInfo(BuildContext context) {
    final theme = Theme.of(context);
    final cardColors = theme.productCardColors;
    
    return InfoCard(
      title: 'Sobre los ingredientes',
      icon: Icons.info,
      backgroundColor: cardColors.warningBackground,
      accentColor: cardColors.warningBorder,
      borderColor: cardColors.warningBorder,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
            context,
            Icons.circle,
            theme.colorScheme.primary,
            'Ingredientes principales',
            'Los primeros 3 ingredientes aparecen en mayor cantidad',
          ),
          const SizedBox(height: AppDesignConstants.paddingSmall),
          _buildInfoRow(
            context,
            Icons.info_outline,
            theme.colorScheme.secondary,
            'Ingredientes destacados',
            'Los siguientes ingredientes importantes del producto',
          ),
          const SizedBox(height: AppDesignConstants.paddingSmall),
          _buildInfoRow(
            context,
            Icons.help_outline,
            theme.colorScheme.outline,
            'Otros ingredientes',
            'Resto de componentes en menor proporción',
          ),
          const SizedBox(height: AppDesignConstants.paddingMedium),
          Text(
            'Los ingredientes se ordenan por cantidad, de mayor a menor según la normativa alimentaria.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: cardColors.warningText.withValues(
                alpha: AppDesignConstants.opacityHeavy,
              ),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon, 
    Color color, 
    String title, 
    String description,
  ) {
    final theme = Theme.of(context);
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: AppDesignConstants.iconSmall,
          color: color,
        ),
        const SizedBox(width: AppDesignConstants.paddingSmall),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              Text(
                description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant.withValues(
                    alpha: AppDesignConstants.opacityHeavy,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
