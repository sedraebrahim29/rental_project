import 'package:flutter/material.dart';

class AmenityItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const AmenityItem({
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
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: theme.colorScheme.primary,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
