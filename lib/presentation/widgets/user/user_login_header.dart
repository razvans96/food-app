import 'package:flutter/material.dart';
import 'package:food_app/presentation/widgets/shared/onboarding_header.dart';


class UserLoginHeader extends StatelessWidget {
  const UserLoginHeader({super.key});

  Widget _buildFeaturesContent(BuildContext context) {
    return Column(
      children: [
        _buildFeatureItem(
          context,
          Icons.analytics_outlined,
          'Consultar información nutricional completa',
        ),
        _buildFeatureItem(
          context,
          Icons.history,
          'Conservar histórico de productos escaneados',
        ),
        _buildFeatureItem(
          context,
          Icons.list_alt,
          'Crear y gestionar listas de productos',
        ),
        _buildFeatureItem(
          context,
          Icons.health_and_safety_outlined,
          'Gestionar preferencias y restricciones alimentarias personales',
        ),
        _buildFeatureItem(
          context,
          Icons.psychology_outlined,
          'Obtener análisis personalizados con IA',
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildFeatureItem(
    BuildContext context,
    IconData icon,
    String text, {
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingHeader(
      title: 'Alimentos',
      subtitle: 'Accede para disfrutar de todas las funcionalidades:',
      titleSpacing: 12,
      contentWidget: _buildFeaturesContent(context),
    );
  }
}
