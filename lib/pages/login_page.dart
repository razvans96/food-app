import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_app/controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LoginController>();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(controller.isLogin ? 'Iniciar sesión' : 'Crear cuenta',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              if (controller.error != null)
                Text(controller.error!, style: const TextStyle(color: Colors.red)),
              if (controller.isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: () {
                    controller.submit(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                    );
                  },
                  child: Text(controller.isLogin ? 'Iniciar sesión' : 'Registrarse'),
                ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: controller.toggleFormType,
                child: Text(controller.isLogin
                    ? '¿No tienes cuenta? Regístrate'
                    : '¿Ya tienes cuenta? Inicia sesión'),
              ),
              const Divider(),
              OutlinedButton.icon(
                onPressed: controller.signInWithGoogle,
                icon: const Icon(Icons.login),
                label: const Text('Iniciar sesión con Google'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
