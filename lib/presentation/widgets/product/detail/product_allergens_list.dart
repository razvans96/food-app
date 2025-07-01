import 'package:flutter/material.dart';
import 'package:food_app/presentation/theme/design_constants.dart';
import 'package:food_app/presentation/theme/theme_extensions.dart';
import 'package:food_app/presentation/widgets/shared/cards/empty_state_card.dart';
import 'package:food_app/presentation/widgets/shared/cards/info_card.dart';

class ProductAllergensList extends StatelessWidget {
  final List<String>? allergens;

  const ProductAllergensList({
    required this.allergens,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDesignConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (allergens != null && allergens!.isNotEmpty) ...[
            _buildAllergensWarningCard(context),
            const SizedBox(height: AppDesignConstants.paddingMedium),
            _buildAllergensCard(context),
          ] else
            _buildNoAllergensCard(context),
          const SizedBox(height: AppDesignConstants.paddingMedium),
          _buildAllergensInfo(context),
        ],
      ),
    );
  }

  Widget _buildAllergensWarningCard(BuildContext context) {
    final theme = Theme.of(context);
    final cardColors = theme.productCardColors;
    
    return Card(
      color: cardColors.errorBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDesignConstants.borderRadiusMedium),
        side: BorderSide(color: cardColors.errorBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDesignConstants.paddingMedium),
        child: Row(
          children: [
            Icon(
              Icons.warning,
              color: cardColors.errorBorder,
              size: AppDesignConstants.iconXLarge,
            ),
            const SizedBox(width: AppDesignConstants.paddingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '⚠️ ATENCIÓN: Contiene alérgenos',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: cardColors.errorText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Este producto contiene ${allergens!.length} alérgeno${allergens!.length > 1 ? 's' : ''} declarado${allergens!.length > 1 ? 's' : ''}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: cardColors.errorText.withValues(
                        alpha: AppDesignConstants.opacityHeavy,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoAllergensCard(BuildContext context) {
    final theme = Theme.of(context);
    final cardColors = theme.productCardColors;
    
    return EmptyStateCard(
      icon: Icons.check_circle,
      title: 'Sin alérgenos declarados',
      description: 'Este producto no declara ninguno de los 14 alérgenos principales',
      backgroundColor: cardColors.successBackground,
      iconColor: cardColors.successBorder,
      textColor: cardColors.successText,
      borderColor: cardColors.successBorder,
    );
  }

  Widget _buildAllergensCard(BuildContext context) {
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
                  Icons.emergency,
                  color: theme.colorScheme.error,
                  size: AppDesignConstants.iconLarge,
                ),
                const SizedBox(width: AppDesignConstants.paddingSmall),
                Text(
                  'Alérgenos Declarados (${allergens!.length})',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDesignConstants.paddingMedium),
            ...allergens!.map((allergen) => _buildAllergenItem(context, allergen)),
          ],
        ),
      ),
    );
  }

  Widget _buildAllergenItem(BuildContext context, String allergen) {
    final theme = Theme.of(context);
    final allergenColors = theme.allergenColors;
    final allergenData = _getAllergenData(allergen);
    final allergenColor = allergenColors.getAllergenColor(allergen);
    
    return Container(
      margin: const EdgeInsets.only(bottom: AppDesignConstants.paddingMedium),
      padding: const EdgeInsets.all(AppDesignConstants.paddingMedium),
      decoration: BoxDecoration(
        color: allergenColor.withValues(alpha: AppDesignConstants.opacityLight),
        borderRadius: BorderRadius.circular(AppDesignConstants.borderRadiusMedium),
        border: Border.all(
          color: allergenColor.withValues(alpha: AppDesignConstants.opacityMedium),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppDesignConstants.paddingSmall),
            decoration: BoxDecoration(
              color: allergenColor.withValues(alpha: AppDesignConstants.opacityMedium),
              shape: BoxShape.circle,
            ),
            child: Icon(
              allergenData['icon'] as IconData,
              color: allergenColor,
              size: AppDesignConstants.iconLarge,
            ),
          ),
          const SizedBox(width: AppDesignConstants.paddingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  allergen,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: allergenColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  allergenData['description'] as String,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant.withValues(
                      alpha: AppDesignConstants.opacityHeavy,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.warning_amber,
            color: allergenColor,
            size: AppDesignConstants.iconMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildAllergensInfo(BuildContext context) {
    final theme = Theme.of(context);
    final cardColors = theme.productCardColors;
    
    return InfoCard(
      title: 'Información sobre alérgenos',
      icon: Icons.info,
      backgroundColor: cardColors.infoBackground,
      accentColor: cardColors.infoBorder,
      borderColor: cardColors.infoBorder,
      content: Text(
        '• Los fabricantes están obligados a declarar los 14 alérgenos principales\n'
        '• Puede contener trazas de otros alérgenos por contaminación cruzada\n'
        '• Si tienes alergias, consulta siempre el etiquetado original del producto\n'
        '• En caso de duda, consulta con tu médico o alergólogo',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: cardColors.infoText.withValues(
            alpha: AppDesignConstants.opacityHeavy,
          ),
          height: 1.4,
        ),
      ),
    );
  }

  Map<String, dynamic> _getAllergenData(String allergen) {
    final allergenLower = allergen.toLowerCase();
    
    if (allergenLower.contains('gluten')) {
      return {
        'icon': Icons.grass,
        'description': 'Presente en trigo, avena, cebada, centeno y sus derivados',
      };
    } else if (allergenLower.contains('leche') || allergenLower.contains('lácteos')) {
      return {
        'icon': Icons.local_drink,
        'description': 'Proteínas de la leche y productos lácteos',
      };
    } else if (allergenLower.contains('huevo')) {
      return {
        'icon': Icons.egg,
        'description': 'Proteínas del huevo y ovoproductos',
      };
    } else if (allergenLower.contains('soja')) {
      return {
        'icon': Icons.grain,
        'description': 'Proteínas de soja y productos derivados',
      };
    } else if (allergenLower.contains('frutos secos') || allergenLower.contains('nueces')) {
      return {
        'icon': Icons.nature,
        'description': 'Frutos de cáscara: almendras, nueces, avellanas, etc.',
      };
    } else if (allergenLower.contains('pescado')) {
      return {
        'icon': Icons.set_meal,
        'description': 'Proteínas de pescado y productos derivados',
      };
    } else if (allergenLower.contains('marisco') || allergenLower.contains('crustáceos')) {
      return {
        'icon': Icons.phishing,
        'description': 'Crustáceos, moluscos y productos derivados',
      };
    } else if (allergenLower.contains('cacahuete')) {
      return {
        'icon': Icons.circle,
        'description': 'Cacahuetes y productos que los contengan',
      };
    } else if (allergenLower.contains('apio')) {
      return {
        'icon': Icons.eco,
        'description': 'Apio y productos derivados',
      };
    } else if (allergenLower.contains('mostaza')) {
      return {
        'icon': Icons.local_florist,
        'description': 'Mostaza y productos que la contengan',
      };
    } else if (allergenLower.contains('sésamo')) {
      return {
        'icon': Icons.circle_outlined,
        'description': 'Semillas de sésamo y productos derivados',
      };
    } else if (allergenLower.contains('sulfitos')) {
      return {
        'icon': Icons.science,
        'description': 'Sulfitos en concentraciones superiores a 10 mg/kg',
      };
    } else if (allergenLower.contains('altramuces')) {
      return {
        'icon': Icons.local_florist,
        'description': 'Altramuces y productos que los contengan',
      };
    } else {
      return {
        'icon': Icons.warning,
        'description': 'Alérgeno identificado en el producto',
      };
    }
  }
}
