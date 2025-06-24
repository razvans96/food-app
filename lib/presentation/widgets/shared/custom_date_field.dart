import 'dart:async';
import 'package:flutter/material.dart';

class CustomDateField extends StatefulWidget {
  const CustomDateField({
    required this.labelText,
    this.validator,
    this.onDateSelected,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.hintText,
    this.prefixIcon = Icons.calendar_today,
    this.autoValidate = false,
    this.validationDelay = const Duration(milliseconds: 500),
    super.key,
  });

  final String labelText;
  final String? Function(DateTime?)? validator;
  final ValueChanged<DateTime?>? onDateSelected;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? hintText;
  final IconData prefixIcon;
  
  final bool autoValidate;
  final Duration validationDelay;

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  final GlobalKey<FormFieldState<DateTime?>> _fieldKey = GlobalKey<FormFieldState<DateTime?>>();
  Timer? _debounceTimer;
  bool _hasBeenInteracted = false;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> _selectDate(BuildContext context) async {
    if (!_hasBeenInteracted) {
      setState(() {
        _hasBeenInteracted = true;
      });
    }

    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? widget.initialDate ?? DateTime(2000),
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime.now(),
      locale: const Locale('es', 'ES'),
    );
    
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      
      _fieldKey.currentState?.didChange(picked);
      
      widget.onDateSelected?.call(picked);
      
      if (widget.autoValidate && _hasBeenInteracted) {
        _debounceTimer?.cancel();
        _debounceTimer = Timer(widget.validationDelay, () {
          if (mounted) {
            _fieldKey.currentState?.validate();
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime?>(
      key: _fieldKey,
      validator: widget.validator,
      builder: (FormFieldState<DateTime?> field) {
        return Column(
          children: [
            InkWell(
              onTap: () => _selectDate(context),
              borderRadius: BorderRadius.circular(12),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: widget.labelText,
                  hintText: widget.hintText ?? 'Selecciona una fecha',
                  prefixIcon: Icon(widget.prefixIcon),
                  errorText: field.errorText,
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
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.error,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                child: Text(
                  _selectedDate != null 
                      ? _formatDate(_selectedDate!)
                      : widget.hintText ?? 'Selecciona una fecha',
                  style: TextStyle(
                    color: _selectedDate != null 
                        ? Theme.of(context).colorScheme.onSurface
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
