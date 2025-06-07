import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/controllers/user_controller.dart';
import 'package:provider/provider.dart';


class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _validateEmail(String value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value.isEmpty) return 'El correo es obligatorio';
    if (!emailRegex.hasMatch(value)) return 'Correo no válido';
    return null;
  }

  String? _validatePassword(String value, bool isLogin) {
    if (value.isEmpty) return 'La contraseña es obligatoria';
    if (!isLogin) {
      final hasLetter = value.contains(RegExp('[A-Za-z]'));
      final hasNumber = value.contains(RegExp(r'\d'));
      if (!hasLetter || !hasNumber) {
        return 'Debe contener letras y números';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UserController>();
    final isLogin = controller.isLogin;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Acceso'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
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
                  Text(controller.error!,
                      style: const TextStyle(color: Colors.red)),
                if (controller.isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        final isNewUser =
                            await controller.signInWithEmailAndPassword(
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                        );
                        if (!mounted) return;
                        if ((isNewUser ?? false) == true) {
                          // Already checked if mounted
                          // ignore: use_build_context_synchronously
                          await Navigator.of(context)
                              .pushReplacementNamed('/register');
                        } else if (isNewUser == false) {
                          // Already checked if mounted
                          // ignore: use_build_context_synchronously
                          await Navigator.of(context).pushReplacementNamed('/home');
                        }
                      }
                    },
                    child: Text(isLogin ? 'Iniciar sesión' : 'Registrarse'),
                  ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: controller.toggleFormType,
                  child: Text(isLogin
                      ? '¿No tienes cuenta? Regístrate'
                      : '¿Ya tienes cuenta? Inicia sesión'),
                ),
                const Divider(),
                OutlinedButton.icon(
                  onPressed: () async {
                    final isNewUser = await controller.signInWithGoogle();
                    if (!mounted) return;
                    if ((isNewUser ?? false) == true) {
                      // Already checked if mounted
                      // ignore: use_build_context_synchronously
                      await Navigator.of(context).pushReplacementNamed('/register');
                    } else if (isNewUser == false) {
                      // Already checked if mounted
                      // ignore: use_build_context_synchronously
                      await Navigator.of(context).pushReplacementNamed('/query');
                    }
                  },
                  icon:
                      const FaIcon(FontAwesomeIcons.google, color: Colors.red),
                  label: const Text('Iniciar sesión con Google'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
