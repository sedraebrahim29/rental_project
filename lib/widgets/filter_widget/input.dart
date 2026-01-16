import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({super.key, this.hint = ''});

  final String hint;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      height: 25,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
      ),
      child: TextField(
        cursorColor: colors.primary,
        keyboardType: TextInputType.number,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: colors.onSurface,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: theme.textTheme.bodySmall?.copyWith(
            color: colors.onSurface.withAlpha(150),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
