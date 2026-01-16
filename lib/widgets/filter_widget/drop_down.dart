import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {
  final List<String> items;
  final Function(int index) onSelected;

  const DropDown({
    super.key,
    required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DropdownButtonFormField<int>(
      initialValue: null, //  بدون قيمة مبدئية
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: theme.colorScheme.primary,
      ),
      dropdownColor: theme.cardColor,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurface,
      ),
      items: List.generate(items.length, (index) {
        return DropdownMenuItem<int>(
          value: index,
          child: Text(items[index]),
        );
      }),
      onChanged: (value) {
        if (value != null) onSelected(value);
      },
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: theme.colorScheme.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
        ),
      ),
    );
  }
}
