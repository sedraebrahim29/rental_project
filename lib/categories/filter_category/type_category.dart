import 'package:flutter/material.dart';

class TypeCategoryp extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const TypeCategoryp({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 105,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.12) // بدل withOpacity
              : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: theme.colorScheme.primary,
            width: isSelected ? 2 : 1.5,
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
