import 'package:flutter/material.dart';
import 'package:rent/l10n/app_localizations.dart';

class BookingDatePicker extends StatelessWidget {
  const BookingDatePicker({super.key,  required this.controller, required this.onPicked,});

  final TextEditingController controller;
  final VoidCallback onPicked;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;//للترجمة
    final theme = Theme.of(context);

    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: theme.colorScheme.primary),
      ),
      child: TextField(
        controller: controller,
        readOnly: true,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: t.date_hint,
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),

        onTap: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
          );

          if (date != null) {
            controller.text =
            '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
            onPicked(); //عم اربط ديت بيكر مع حساب السعر
          }
        },
      ),
    );
  }
}
