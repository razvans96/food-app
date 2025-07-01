import 'package:flutter/material.dart';
import 'package:food_app/presentation/theme/design_constants.dart';

class EmptyStateCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final Color? borderColor;

  const EmptyStateCard({
    required this.icon,
    required this.title,
    required this.description,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
    this.borderColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Card(
      color: backgroundColor ?? colorScheme.primaryContainer.withValues(alpha: 0.3),
      shape: borderColor != null 
        ? RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDesignConstants.borderRadiusMedium),
            side: BorderSide(color: borderColor!),
          )
        : null,
      child: Padding(
        padding: const EdgeInsets.all(AppDesignConstants.paddingLarge),
        child: Column(
          children: [
            Icon(
              icon,
              color: iconColor ?? colorScheme.primary,
              size: AppDesignConstants.iconXXLarge,
            ),
            const SizedBox(height: AppDesignConstants.paddingMedium),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: textColor ?? colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: AppDesignConstants.paddingSmall),
            Text(
              description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: textColor?.withValues(alpha: 0.8) ?? 
                       colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
