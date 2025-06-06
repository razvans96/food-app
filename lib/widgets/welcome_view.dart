import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Bienvenido a Alimentos',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
        Text(
          'Escanea tu producto',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
