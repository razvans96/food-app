import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/presentation/view_models/auth_view_model.dart';
import 'package:food_app/shared/config/dependency_injection.dart';
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
    return ChangeNotifierProvider.value(
      value: getIt<AuthViewModel>(),
      child: Scaffold(
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
            child: Consumer<AuthViewModel>(
              builder: (context, viewModel, _) {
                return Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        viewModel.isLogin ? 'Iniciar sesión' : 'Crear cuenta',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
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
                        validator: (value) => _validatePassword(value ?? '', viewModel.isLogin),
                      ),
                      const SizedBox(height: 20),
                      if (viewModel.error != null)
                        Text(
                          viewModel.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      if (viewModel.isLoading)
                        const CircularProgressIndicator()
                      else
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              final isNewUser = await viewModel.signInWithEmailAndPassword(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                              );
                              if (!mounted) return;
                              
                              await _handleAuthResult(context, viewModel, isNewUser);
                            }
                          },
                          child: Text(viewModel.isLogin ? 'Iniciar sesión' : 'Registrarse'),
                        ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: viewModel.toggleFormType,
                        child: Text(viewModel.isLogin
                            ? '¿No tienes cuenta? Regístrate'
                            : '¿Ya tienes cuenta? Inicia sesión'),
                      ),
                      const Divider(),
                      OutlinedButton.icon(
                        onPressed: () async {
                          final isNewUser = await viewModel.signInWithGoogle();
                          if (!mounted) return;
                          
                          await _handleAuthResult(context, viewModel, isNewUser);
                        },
                        icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red),
                        label: const Text('Iniciar sesión con Google'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleAuthResult(BuildContext context, AuthViewModel viewModel, bool? isNewUser) async {
    if (isNewUser == true) {
      await Navigator.of(context).pushNamedAndRemoveUntil('/register', (route) => false);
    } else if (isNewUser == false) {
      final userStatus = await viewModel.checkUserValidity();
      if (!mounted) return;
      
      if (userStatus == 'register') {
        // Usuario autenticado pero sin perfil completo
        await Navigator.of(context).pushNamedAndRemoveUntil('/register', (route) => false);
      } else if (userStatus == 'home') {
        // Usuario con perfil completo
        await Navigator.of(context).pushReplacementNamed('/query');
      }
    }
  }
}
