import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/presentation/view_models/authentication_view_model.dart';
import 'package:food_app/presentation/view_models/states/authentication_state.dart';
import 'package:food_app/presentation/view_models/states/user_login_state.dart';
import 'package:food_app/presentation/view_models/user_login_view_model.dart';
import 'package:food_app/shared/config/dependency_injection.dart';
import 'package:provider/provider.dart';

enum LoginMethod { email, google }

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  

  LoginMethod _selectedMethod = LoginMethod.email;

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

  Widget _buildHeader() {
    return Column(
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: ClipOval(
            child: Image.asset(
              'assets/icon/mipmap-hdpi/ic_launcher.png', // Tu ícono generado
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.restaurant,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Alimentos',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Accede para disfrutar de todas las funcionalidades:',
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
          child: Column(
            children: [
              _buildFeatureItem(
                Icons.analytics_outlined,
                'Consultar información nutricional completa',
              ),
              _buildFeatureItem(
                Icons.history,
                'Conservar histórico de productos escaneados',
              ),
              _buildFeatureItem(
                Icons.list_alt,
                'Crear y gestionar listas de productos',
              ),
              _buildFeatureItem(
                Icons.health_and_safety_outlined,
                'Gestionar restricciones alimenticias personales',
              ),
              _buildFeatureItem(
                Icons.psychology_outlined,
                'Obtener análisis personalizados con IA',
                isLast: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureItem(IconData icon, String text, {bool isLast = false}) {
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

  Widget _buildLoginMethodToggle() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SegmentedButton<LoginMethod>(
        segments: const [
          ButtonSegment<LoginMethod>(
            value: LoginMethod.email,
            label: Text('Email'),
            icon: Icon(Icons.email_outlined),
          ),
          ButtonSegment<LoginMethod>(
            value: LoginMethod.google,
            label: Text('Google'),
            icon: FaIcon(FontAwesomeIcons.google, size: 16),
          ),
        ],
        selected: <LoginMethod>{_selectedMethod},
        onSelectionChanged: (Set<LoginMethod> newSelection) {
          setState(() {
            _selectedMethod = newSelection.first;
          });
          FocusScope.of(context).unfocus();
        },
        style: SegmentedButton.styleFrom(
          selectedBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
          selectedForegroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }

  Widget _buildEmailForm(UserLoginViewModel loginViewModel) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: _selectedMethod == LoginMethod.email 
        ? Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  validator: (value) => _validateEmail(value ?? ''),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'tu@email.com',
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) => _validatePassword(value ?? '', loginViewModel.isLogin),
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    hintText: 'Tu contraseña segura',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: () => _handleEmailPasswordLogin(loginViewModel),
                    icon: const Icon(Icons.login),
                    label: Text(
                      loginViewModel.isLogin ? 'Iniciar sesión' : 'Crear cuenta',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 12),
                
                InkWell(
                  onTap: () => loginViewModel.toggleFormType(),
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text(
                      loginViewModel.isLogin
                          ? '¿No tienes cuenta? Regístrate'
                          : '¿Ya tienes cuenta? Inicia sesión',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink(),
    );
  }

  Widget _buildGoogleLogin(UserLoginViewModel loginViewModel) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: _selectedMethod == LoginMethod.google
        ? Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Accede rápidamente con tu cuenta de Google',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton.icon(
                  onPressed: () => _handleGoogleLogin(loginViewModel),
                  icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red),
                  label: const Text(
                    'Continuar con Google',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          )
        : const SizedBox.shrink(),
    );
  }

  Widget _buildErrorMessage(String message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.error.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.onErrorContainer,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onErrorContainer,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: getIt<UserLoginViewModel>(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text('Acceso'),
          elevation: 0,
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Consumer<UserLoginViewModel>(
            builder: (context, loginViewModel, _) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          _buildHeader(),
                          const SizedBox(height: 32),
                          
                          _buildLoginMethodToggle(),
                          const SizedBox(height: 24),
                          
                          if (loginViewModel.state case Error(:final message))
                            _buildErrorMessage(message),
                          
                          switch (loginViewModel.state) {
                            Loading() => const Padding(
                              padding: EdgeInsets.all(32),
                              child: CircularProgressIndicator(),
                            ),
                            _ => Column(
                              children: [
                                _buildEmailForm(loginViewModel),
                                _buildGoogleLogin(loginViewModel),
                              ],
                            ),
                          },
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

 Future<void> _handleEmailPasswordLogin(UserLoginViewModel loginViewModel) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    await loginViewModel.signInWithEmailAndPassword(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (!mounted) return;
    if (loginViewModel.state is Success) {
      await _handleSuccessfulAuth();
    }
  }

  Future<void> _handleGoogleLogin(UserLoginViewModel loginViewModel) async {
    await loginViewModel.signInWithGoogle();
    
    if (!mounted) return;
    if (loginViewModel.state is Success) {
      await _handleSuccessfulAuth();
    }
  }

  Future<void> _handleSuccessfulAuth() async {
    final authViewModel = context.read<AuthenticationViewModel>();
    await authViewModel.checkAuthenticationStatus();
    
    if (!mounted) return;

    switch (authViewModel.state) {
      case ProfileIncomplete():
        await Navigator.of(context).pushNamedAndRemoveUntil('/register', (route) => false);
      default:
        await Navigator.of(context).pushNamedAndRemoveUntil('/query', (route) => false);
    }
  }
}
