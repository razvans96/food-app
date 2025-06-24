import 'package:flutter/material.dart';

class UserDietaryRestrictionsField extends StatefulWidget {
  const UserDietaryRestrictionsField({
    required this.restrictions,
    required this.onRestrictionsChanged,
    super.key,
  });

  final List<String> restrictions;
  final ValueChanged<List<String>> onRestrictionsChanged;

  @override
  State<UserDietaryRestrictionsField> createState() => _UserDietaryRestrictionsFieldState();
}

class _UserDietaryRestrictionsFieldState extends State<UserDietaryRestrictionsField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addRestriction() {
    final restriction = _controller.text.trim();
    if (restriction.isNotEmpty && !widget.restrictions.contains(restriction)) {
      final updatedRestrictions = [...widget.restrictions, restriction];
      widget.onRestrictionsChanged(updatedRestrictions);
      _controller.clear();
    }
  }

  void _removeRestriction(String restriction) {
    final updatedRestrictions = widget.restrictions.where((r) => r != restriction).toList();
    widget.onRestrictionsChanged(updatedRestrictions);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'Restricciones alimentarias (opcional)',
            hintText: 'Ej: vegetariano, sin gluten, sin lactosa...',
            prefixIcon: const Icon(Icons.health_and_safety_outlined),
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
            suffixIcon: IconButton(
              onPressed: _addRestriction,
              icon: const Icon(Icons.add),
              tooltip: 'Añadir restricción',
            ),
          ),
          onFieldSubmitted: (_) => _addRestriction(),
        ),
        
        const SizedBox(height: 12),
        
        if (widget.restrictions.isNotEmpty) ...[
          Text(
            'Tus restricciones:',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.restrictions.map((restriction) {
              return Chip(
                label: Text(
                  restriction,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontSize: 12,
                  ),
                ),
                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                deleteIcon: Icon(
                  Icons.close,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                onDeleted: () => _removeRestriction(restriction),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              );
            }).toList(),
          ),
        ],
        
        if (widget.restrictions.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Opcional: Nos ayuda a personalizar tu experiencia',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }
}
