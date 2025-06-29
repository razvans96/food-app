import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/presentation/view_models/authentication_view_model.dart';
import 'package:food_app/presentation/view_models/states/user_register_state.dart';
import 'package:food_app/presentation/view_models/user_register_view_model.dart';
import 'package:food_app/presentation/widgets/shared/custom_date_field.dart';
import 'package:food_app/presentation/widgets/shared/custom_text_field.dart';
import 'package:food_app/presentation/widgets/shared/error_message.dart';
import 'package:food_app/presentation/widgets/user/user_dietary_restrictions_field.dart';
import 'package:food_app/presentation/widgets/user/user_register_header.dart';
import 'package:food_app/shared/config/dependency_injection.dart';
import 'package:provider/provider.dart';

class UserRegisterPage extends StatefulWidget {
  const UserRegisterPage({super.key});

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _phoneController = TextEditingController();
  
  DateTime? _selectedDate;
  List<String> _dietaryRestrictions = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (FirebaseAuth.instance.currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed('/login');
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _handleClose() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushReplacementNamed('/query');
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) return 'Campo obligatorio';
    final nameRegex = RegExp(r'^[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+$');
    if (!nameRegex.hasMatch(value)) return 'Solo letras y espacios';
    return null;
  }

  String? _validateSurname(String? value) {
    if (value == null || value.isEmpty) return 'Campo obligatorio';
    final surnameRegex = RegExp(r'^[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+$');
    if (!surnameRegex.hasMatch(value)) return 'Solo letras y espacios';
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
    return null;
    }
    
    final phoneRegex = RegExp(r'^[6-9]\d{8}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Introduce un teléfono válido (9 dígitos, empezando por 6-9)';
    }
    
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: getIt<UserRegisterViewModel>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Completa tu perfil'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: _handleClose,
              icon: const Icon(Icons.close),
              tooltip: 'Cerrar',
            ),
          ],
          elevation: 0,
        ),
        body: Consumer<UserRegisterViewModel>(
          builder: (context, registerViewModel, _) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const UserRegisterHeader(),
                    const SizedBox(height: 32),
                    
                    CustomTextField(
                      controller: _nameController,
                      labelText: 'Nombre*',
                      prefixIcon: Icons.person_outline,
                      validator: _validateName,
                      autoValidate: true,
                    ),
                    const SizedBox(height: 16),
                    
                    CustomTextField(
                      controller: _surnameController,
                      labelText: 'Apellidos*',
                      prefixIcon: Icons.person_outline,
                      validator: _validateSurname,
                      autoValidate: true,
                    ),
                    const SizedBox(height: 16),

                    CustomDateField(
                      labelText: 'Fecha de nacimiento*',
                      hintText: 'Selecciona tu fecha de nacimiento',
                      validator: (date) {
                        if (date == null) return 'Campo obligatorio';
                        return null;
                      },
                      onDateSelected: (date) => setState(() => _selectedDate = date),
                      autoValidate: true,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                      initialDate: DateTime(2000),
                    ),
                    const SizedBox(height: 16),
                    
                    CustomTextField(
                      controller: _phoneController,
                      labelText: 'Teléfono (opcional)',
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: _validatePhone,
                      autoValidate: true,
                      validationDelay: const Duration(milliseconds: 800),
                    ),
                    const SizedBox(height: 16),

                    UserDietaryRestrictionsField(
                      restrictions: _dietaryRestrictions,
                      onRestrictionsChanged: (restrictions) => 
                        setState(() => _dietaryRestrictions = restrictions),
                    ),
                    const SizedBox(height: 32),
                    
                    if (registerViewModel.state case Error(:final message))
                      ErrorMessageWidget(message: message),
                    
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: switch (registerViewModel.state) {
                        Loading() => ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const CircularProgressIndicator(),
                        ),
                        _ => ElevatedButton.icon(
                          onPressed: () => _handleRegister(registerViewModel),
                          icon: const Icon(Icons.check),
                          label: const Text(
                            'Completar perfil',
                            style: TextStyle(
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
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _handleRegister(UserRegisterViewModel registerViewModel) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final success = await registerViewModel.registerProfile(
      userName: _nameController.text.trim(),
      userSurname: _surnameController.text.trim(),
      userPhone: _phoneController.text.trim(),
      userDob: _selectedDate!,
      userDietaryRestrictions: _dietaryRestrictions,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil registrado correctamente')),
      );

      final authViewModel = context.read<AuthenticationViewModel>();
      await authViewModel.checkAuthenticationStatus();
      
      if (!mounted) return;

      await Navigator.of(context).pushNamedAndRemoveUntil('/query', (route) => false);
    }
  }
}
