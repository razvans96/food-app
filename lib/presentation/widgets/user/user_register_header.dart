import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/presentation/widgets/shared/onboarding_header.dart';


class UserRegisterHeader extends StatelessWidget {
  const UserRegisterHeader({super.key});

  String _buildDynamicTitle() {
    final user = FirebaseAuth.instance.currentUser;
    return '¡Hola${user?.email != null ? ', ${user!.email!.split('@')[0]}' : ''}!';
  }

  Widget _buildPrivacyContent(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.privacy_tip_outlined,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(
              'Privacidad y transparencia',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Tus restricciones alimentarias se enviarán de forma anónima a nuestros modelos de IA para ofrecerte análisis personalizados. Nunca compartiremos tus datos personales completos.',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 12,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingHeader(
      title: _buildDynamicTitle(),
      subtitle: 'Completa tu perfil para obtener perspectivas nutricionales personalizadas con IA',
      contentWidget: _buildPrivacyContent(context),
    );
  }
}
