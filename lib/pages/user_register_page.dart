import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controllers/user_controller.dart';
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
  final _dobController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (FirebaseAuth.instance.currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed('/login');
      });
    }
  }

  String? _validateName(String value) {
    if (value.isEmpty) return 'Campo obligatorio';
    final nameRegex = RegExp(r'^[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+$');
    if (!nameRegex.hasMatch(value)) return 'Solo letras y espacios';
    return null;
  }

  String? _validateSurname(String value) {
    if (value.isEmpty) return 'Campo obligatorio';
    final surnameRegex = RegExp(r'^[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+$');
    if (!surnameRegex.hasMatch(value)) return 'Solo letras y espacios';
    return null;
  }

  String? _validatePhone(String value) {
    if (value.isEmpty) return 'Campo obligatorio';
    final phoneRegex = RegExp(r'^[6-9]\d{8}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Introduce un teléfono válido';
    }
    return null;
  }

  String? _validateDob(String value) {
    if (value.isEmpty) return 'Campo obligatorio';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final userController = context.watch<UserController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completa tu perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (v) => _validateName(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _surnameController,
                decoration: const InputDecoration(labelText: 'Apellidos'),
                validator: (v) => _validateSurname(v ?? ''),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                    ),
                    child: const Text(
                      '+34',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: 'Teléfono'),
                      keyboardType: TextInputType.phone,
                      validator: (v) => _validatePhone(v ?? ''),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _dobController,
                decoration:
                    const InputDecoration(labelText: 'Fecha de nacimiento'),
                readOnly: true,
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    _dobController.text =
                        '${picked.day}/${picked.month}/${picked.year}';
                  }
                },
                validator: (v) => _validateDob(v ?? ''),
              ),
              const SizedBox(height: 24),
              if (userController.error != null)
                Text(userController.error!,
                    style: const TextStyle(color: Colors.red)),
              if (userController.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      userController.registerProfile(
                        userName: _nameController.text.trim(),
                        userSurname: _surnameController.text.trim(),
                        userPhone: _phoneController.text.trim(),
                        userDob: _dobController.text.trim(),
                      );
                      if (!mounted) return;
                      if (userController.error == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Perfil registrado correctamente'),
                          ),
                        );
                        Navigator.of(context).pushReplacementNamed('/query');
                      }
                    }
                  },
                  child: const Text('Registrar'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
