import 'package:flutter/material.dart';

class OnboardingHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget contentWidget;
  final double titleSpacing;

  const OnboardingHeader({
    required this.title, required this.subtitle, required this.contentWidget, super.key,
    this.titleSpacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: ClipOval(
            child: Image.asset(
              'assets/icon/mipmap-hdpi/ic_launcher.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.restaurant,
                  size: 30,
                  color: Theme.of(context).colorScheme.primary,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        SizedBox(height: titleSpacing),
        
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          child: contentWidget,
        ),
      ],
    );
  }
}
