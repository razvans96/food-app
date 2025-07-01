import 'package:flutter/material.dart';
import 'package:food_app/domain/entities/product_entity.dart';
import 'package:food_app/domain/value_objects/nutritional_value.dart';
import 'package:food_app/presentation/theme/design_constants.dart';
import 'package:food_app/presentation/theme/theme_extensions.dart';
import 'package:food_app/presentation/widgets/shared/cards/empty_state_card.dart';
import 'package:food_app/presentation/widgets/shared/cards/info_card.dart';
import 'package:food_app/presentation/widgets/shared/cards/nutrient_group_card.dart';

class ProductNutritionalInfo extends StatelessWidget {
  final ProductEntity product;

  const ProductNutritionalInfo({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final nutritionalValues = product.nutritionalValues;
    
    if (nutritionalValues == null) {
      return _buildNoDataCard(context);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDesignConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEnergyCard(context, nutritionalValues),
          const SizedBox(height: AppDesignConstants.paddingMedium),
          _buildMacronutrientsCard(context, nutritionalValues),
          const SizedBox(height: AppDesignConstants.paddingMedium),
          _buildMicronutrientsCard(context, nutritionalValues),
          const SizedBox(height: AppDesignConstants.paddingMedium),
          _buildNutritionalFooter(context),
        ],
      ),
    );
  }

  Widget _buildNoDataCard(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(AppDesignConstants.paddingMedium),
        child: EmptyStateCard(
          icon: Icons.info_outline,
          title: 'Información nutricional no disponible',
          description: 'No se encontraron datos nutricionales para este producto',
        ),
      ),
    );
  }

  Widget _buildEnergyCard(BuildContext context, NutritionalValues nutritionalValues) {
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
                  Icons.local_fire_department,
                  color: theme.colorScheme.tertiary,
                  size: AppDesignConstants.iconLarge,
                ),
                const SizedBox(width: AppDesignConstants.paddingSmall),
                Text(
                  'Valor Energético',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDesignConstants.paddingMedium),
            if (nutritionalValues.energy != null) ...[
              _buildEnergyRow(
                context,
                'Energía (kcal)',
                '${nutritionalValues.energy!.valueKcal.toStringAsFixed(0)} kcal',
                theme.colorScheme.tertiary,
              ),
              const SizedBox(height: AppDesignConstants.paddingSmall),
              _buildEnergyRow(
                context,
                'Energía (kJ)',
                '${nutritionalValues.energy!.valueKj.toStringAsFixed(0)} kJ',
                theme.colorScheme.tertiary.withValues(alpha: AppDesignConstants.opacityHeavy),
              ),
            ] else
              _buildNutrientUnavailable(context, 'Información energética'),
          ],
        ),
      ),
    );
  }

  Widget _buildMacronutrientsCard(BuildContext context, NutritionalValues nutritionalValues) {
    final theme = Theme.of(context);
    
    return NutrientGroupCard(
      icon: Icons.pie_chart,
      title: 'Macronutrientes',
      accentColor: theme.colorScheme.primary,
      nutrients: [
        _buildNutrientRow(context, 'Grasas', nutritionalValues.fat, theme.colorScheme.error),
        _buildNutrientRow(context, '- Saturadas', nutritionalValues.saturatedFat, theme.colorScheme.error.withValues(alpha: AppDesignConstants.opacityHeavy)),
        const Divider(height: AppDesignConstants.paddingMedium),
        _buildNutrientRow(context, 'Carbohidratos', nutritionalValues.carbohydrates, theme.colorScheme.tertiary),
        _buildNutrientRow(context, '- Azúcares', nutritionalValues.sugars, theme.colorScheme.tertiary.withValues(alpha: AppDesignConstants.opacityHeavy)),
        const Divider(height: AppDesignConstants.paddingMedium),
        _buildNutrientRow(context, 'Fibra', nutritionalValues.fiber, theme.colorScheme.primary),
        _buildNutrientRow(context, 'Proteínas', nutritionalValues.proteins, theme.colorScheme.secondary),
        _buildNutrientRow(context, 'Sal', nutritionalValues.salt, theme.colorScheme.outline),
      ],
    );
  }

  Widget _buildMicronutrientsCard(BuildContext context, NutritionalValues nutritionalValues) {
    final theme = Theme.of(context);
    final hasMicronutrients = nutritionalValues.calcium != null ||
        nutritionalValues.iron != null ||
        nutritionalValues.vitaminC != null ||
        nutritionalValues.sodium != null;

    if (!hasMicronutrients) {
      return NutrientGroupCard(
        icon: Icons.medication,
        title: 'Micronutrientes',
        accentColor: theme.colorScheme.secondary,
        nutrients: [
          _buildNutrientUnavailable(context, 'Información de micronutrientes'),
        ],
      );
    }

    final micronutrients = <Widget>[];
    if (nutritionalValues.sodium != null) {
      micronutrients.add(_buildNutrientRow(context, 'Sodio', nutritionalValues.sodium, theme.colorScheme.outline));
    }
    if (nutritionalValues.calcium != null) {
      micronutrients.add(_buildNutrientRow(context, 'Calcio', nutritionalValues.calcium, Colors.grey[700]!));
    }
    if (nutritionalValues.iron != null) {
      micronutrients.add(_buildNutrientRow(context, 'Hierro', nutritionalValues.iron, Colors.brown[400]!));
    }
    if (nutritionalValues.vitaminC != null) {
      micronutrients.add(_buildNutrientRow(context, 'Vitamina C', nutritionalValues.vitaminC, Colors.yellow[600]!));
    }

    return NutrientGroupCard(
      icon: Icons.medication,
      title: 'Micronutrientes',
      accentColor: theme.colorScheme.secondary,
      nutrients: micronutrients,
    );
  }

  Widget _buildEnergyRow(BuildContext context, String label, String value, Color color) {
    final theme = Theme.of(context);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDesignConstants.paddingMedium, 
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: color.withValues(alpha: AppDesignConstants.opacityLight),
            borderRadius: BorderRadius.circular(AppDesignConstants.borderRadiusMedium),
            border: Border.all(
              color: color.withValues(alpha: AppDesignConstants.opacityMedium),
            ),
          ),
          child: Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNutrientRow(BuildContext context, String label, NutrientValue? nutrient, Color color) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface,
            ),
          ),
          if (nutrient != null)
            Text(
              '${nutrient.value} ${nutrient.unit}',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            )
          else
            Text(
              'No disponible',
              style: theme.textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
                color: theme.colorScheme.onSurfaceVariant.withValues(
                  alpha: AppDesignConstants.opacityHeavy,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNutrientUnavailable(BuildContext context, String message) {
    final theme = Theme.of(context);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDesignConstants.paddingMedium),
        child: Column(
          children: [
            Icon(
              Icons.help_outline,
              size: AppDesignConstants.iconXLarge,
              color: theme.colorScheme.onSurfaceVariant.withValues(
                alpha: AppDesignConstants.opacityMedium,
              ),
            ),
            const SizedBox(height: AppDesignConstants.paddingSmall),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant.withValues(
                  alpha: AppDesignConstants.opacityHeavy,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionalFooter(BuildContext context) {
    final theme = Theme.of(context);
    final cardColors = theme.productCardColors;
    
    return InfoCard(
      title: 'Información nutricional',
      icon: Icons.info,
      backgroundColor: cardColors.infoBackground,
      accentColor: cardColors.infoBorder,
      borderColor: cardColors.infoBorder,
      content: Text(
        'Valores nutricionales por 100g/100ml de producto. Los valores pueden variar según el lote y la fecha de fabricación.',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: cardColors.infoText.withValues(
            alpha: AppDesignConstants.opacityHeavy,
          ),
          height: 1.4,
        ),
      ),
    );
  }
}
