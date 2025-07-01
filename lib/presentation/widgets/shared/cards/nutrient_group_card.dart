import 'package:flutter/material.dart';
import 'package:food_app/presentation/theme/design_constants.dart';

class NutrientGroupCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Widget> nutrients;
  final Color? accentColor;
  final Color? backgroundColor;

  const NutrientGroupCard({
    required this.icon,
    required this.title,
    required this.nutrients,
    this.accentColor,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final effectiveAccentColor = accentColor ?? colorScheme.primary;
    
    return Card(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(AppDesignConstants.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: effectiveAccentColor,
                  size: AppDesignConstants.iconLarge,
                ),
                const SizedBox(width: AppDesignConstants.paddingSmall),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: AppDesignConstants.paddingXLarge),
            ...nutrients,
          ],
        ),
      ),
    );
  }
}
