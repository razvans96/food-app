import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_app/controllers/register_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

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
    final nameRegex = RegExp(r"^[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+$");
    if (!nameRegex.hasMatch(value)) return 'Solo letras y espacios';
    return null;
  }

  String? _validateSurname(String value) {
    if (value.isEmpty) return 'Campo obligatorio';
    final surnameRegex = RegExp(r"^[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+$");
    if (!surnameRegex.hasMatch(value)) return 'Solo letras y espacios';
    return null;
  }

  String? _validatePhone(String value) {
    if (value.isEmpty) return 'Campo obligatorio';
    final phoneRegex = RegExp(r"^\+\d{1,3}\s?\d{6,14}$");
    if (!phoneRegex.hasMatch(value)) return 'Introduce un teléfono válido con prefijo (+34...)';
    return null;
  }

  String? _validateDob(String value) {
    if (value.isEmpty) return 'Campo obligatorio';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RegisterController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Completa tu perfil')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
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
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.phone,
                validator: (v) => _validatePhone(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _dobController,
                decoration: const InputDecoration(labelText: 'Fecha de nacimiento'),
                readOnly: true,
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000, 1, 1),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
                  }
                },
                validator: (v) => _validateDob(v ?? ''),
              ),
              const SizedBox(height: 24),
              if (controller.error != null)
                Text(controller.error!, style: const TextStyle(color: Colors.red)),
              if (controller.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      controller.submit(
                        name: _nameController.text.trim(),
                        surname: _surnameController.text.trim(),
                        phone: _phoneController.text.trim(),
                        dob: _dobController.text.trim(),
                      );
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