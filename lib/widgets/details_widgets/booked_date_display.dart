import 'package:flutter/material.dart';
import 'package:rent/l10n/app_localizations.dart';

class BookedDateDisplay extends StatelessWidget {
  const BookedDateDisplay({
    super.key,
    required this.bookedDates,
  });

  final List bookedDates;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      width: 320,
      height: 50,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.primary),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 15, top: 5, bottom: 5),
        child: Scrollbar(
          thickness: 6,
          radius: const Radius.circular(10),
          child: ListView.builder(
            itemCount: bookedDates.length,
            itemBuilder: (context, index) {
              final b = bookedDates[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Center(
                  child: Text(
                    '${t.from} : ${b.startDate}      ${t.to} : ${b.endDate}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
