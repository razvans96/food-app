import 'dart:async';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    required this.controller,
    required this.labelText,
    this.validator,
    this.keyboardType,
    this.prefixIcon,
    this.hintText,
    this.autoValidate = false,
    this.validationDelay = const Duration(milliseconds: 500),
    super.key,
  });

  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final String? hintText;
  
  final bool autoValidate;
  final Duration validationDelay;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final GlobalKey<FormFieldState<String>> _fieldKey = GlobalKey<FormFieldState<String>>();
  Timer? _debounceTimer;
  bool _hasBeenInteracted = false;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onChanged(String value) {
    if (!widget.autoValidate || !_hasBeenInteracted) return;
    
    _debounceTimer?.cancel();
    _debounceTimer = Timer(widget.validationDelay, () {
      if (mounted) {
        _fieldKey.currentState?.validate();
      }
    });
  }

  void _onTap() {
    if (!_hasBeenInteracted) {
      setState(() {
        _hasBeenInteracted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _fieldKey,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onChanged: _onChanged,
      onTap: _onTap,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
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
    );
  }
}
