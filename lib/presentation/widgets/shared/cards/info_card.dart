import 'package:flutter/material.dart';
import 'package:food_app/presentation/theme/design_constants.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final Widget content;
  final Color? backgroundColor;
  final Color? accentColor; // ✨ AÑADIDO: Para el contenido
  final Color? borderColor;  // ✨ AÑADIDO: Para aprovechar ProductCardColors
  final IconData? icon;

  const InfoCard({
    required this.title,
    required this.content,
    this.backgroundColor,
    this.accentColor,
    this.borderColor,  // ✨ NUEVO
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final effectiveAccentColor = accentColor ?? colorScheme.secondary;
    
    return Card(
      color: backgroundColor ?? colorScheme.secondaryContainer.withValues(alpha: 0.3),
      // ✨ AÑADIDO: Shape con border opcional
      shape: borderColor != null 
        ? RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDesignConstants.borderRadiusMedium),
            side: BorderSide(color: borderColor!),
          )
        : null,
      child: Padding(
        padding: const EdgeInsets.all(AppDesignConstants.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: effectiveAccentColor,
                    size: AppDesignConstants.iconMedium,
                  ),
                  const SizedBox(width: AppDesignConstants.paddingSmall),
                ],
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: effectiveAccentColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDesignConstants.paddingMedium),
            content,
          ],
        ),
      ),
    );
  }
}
