import 'package:flutter/material.dart';

class FilterInfoRow extends StatelessWidget {
  const FilterInfoRow({
    super.key,
    required this.label,
    required this.field,
  });

  final String label;
  final Widget field;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        SizedBox(
          width: 140,
          child: Text(
            '$label :',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        Expanded(child: field),
      ],
    );
  }
}
