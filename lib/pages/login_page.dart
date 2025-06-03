import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_app/controllers/login_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _validateEmail(String value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value.isEmpty) return 'El correo es obligatorio';
    if (!emailRegex.hasMatch(value)) return 'Correo no válido';
    return null;
  }

  String? _validatePassword(String value, bool isLogin) {
    if (value.isEmpty) return 'La contraseña es obligatoria';
    if (!isLogin) {
      final hasLetter = value.contains(RegExp(r'[A-Za-z]'));
      final hasNumber = value.contains(RegExp(r'\d'));
      if (!hasLetter || !hasNumber) {
        return 'Debe contener letras y números';
      }
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LoginController>();
    final isLogin = controller.isLogin;
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(isLogin ? 'Iniciar sesión' : 'Crear cuenta',
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  validator: (value) => _validateEmail(value ?? ''),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  obscureText: true,
                  validator: (value) => _validatePassword(value ?? '', isLogin),
                ),
                const SizedBox(height: 20),
                if (controller.error != null)
                  Text(controller.error!, style: const TextStyle(color: Colors.red)),
                if (controller.isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        final isNewUser = await controller.submit(
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                        );
                        if (!mounted) return;
                        if (isNewUser == true) {
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushReplacementNamed('/register');
                        } else if (isNewUser == false) {
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushReplacementNamed('/home');
                        }
                      }
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
                  onPressed: () async {
                    final isNewUser = await controller.signInWithGoogle();
                    if (!mounted) return;
                    if (isNewUser == true){
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushReplacementNamed('/register');
                    } else if (isNewUser == false) {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushReplacementNamed('/home');
                    } 
                  },
                  icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red),
                  label: const Text('Iniciar sesión con Google'),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
