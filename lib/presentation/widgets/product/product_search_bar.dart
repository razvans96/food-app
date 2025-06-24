import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum SearchInputType { 
  text,
  numeric
}

class ProductSearchBar extends StatelessWidget {
  const ProductSearchBar({
    required this.controller,
    required this.onSearch,
    super.key,
    this.inputType = SearchInputType.text,
    this.hintText,
    this.labelText,
  });

  final TextEditingController controller;
  final VoidCallback onSearch;
  final SearchInputType inputType;
  final String? hintText;
  final String? labelText;

  TextInputType get _keyboardType {
    switch (inputType) {
      case SearchInputType.text:
        return TextInputType.text;
      case SearchInputType.numeric:
        return TextInputType.number;
    }
  }

  List<TextInputFormatter> get _inputFormatters {
    switch (inputType) {
      case SearchInputType.text:
        return [];
      case SearchInputType.numeric:
        return [FilteringTextInputFormatter.digitsOnly];
    }
  }

  String get _defaultHintText {
    switch (inputType) {
      case SearchInputType.text:
        return hintText ?? 'Introduces el término de búsuqeda';
      case SearchInputType.numeric:
        return hintText ?? 'Introduce el código de barras';
    }
  }

  String? get _defaultLabelText {
    switch (inputType) {
      case SearchInputType.text:
        return labelText;
      case SearchInputType.numeric:
        return labelText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: (_) => onSearch(),
      keyboardType: _keyboardType,
      inputFormatters: _inputFormatters,
      decoration: InputDecoration(
        hintText: _defaultHintText,
        labelText: _defaultLabelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.search),
          onPressed: onSearch,
          tooltip: 'Buscar',
        ),
      ),
    );
  }
}
