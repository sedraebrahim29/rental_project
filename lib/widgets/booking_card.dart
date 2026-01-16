import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rent/l10n/app_localizations.dart';
import '../models/booking_model.dart';

class BookingCard extends StatelessWidget {
  final BookingModel booking;
  final VoidCallback? onAction; // For "Edit", "Cancel", or "Rate"

  const BookingCard({super.key, required this.booking, this.onAction});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!; // للترجمة
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final dateFormat = DateFormat('dd-MM-yyyy');

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.primary.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildImage(booking.property.imageUrls.first),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.property.ownerName,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colors.primary,
                      ),
                    ),
                    Text(
                      "${t.from}: ${dateFormat.format(booking.fromDate)}",
                      style: theme.textTheme.bodySmall,
                    ),
                    Text(
                      "${t.to}: ${dateFormat.format(booking.toDate)}",
                      style: theme.textTheme.bodySmall,
                    ),
                    Text(
                      "${t.total_price}: \$${booking.totalPrice}",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colors.error,
                      ),
                    ),
                  ],
                ),
              ),
              _buildActionButton(context, t),
            ],
          ),
          if (booking.statusMessage != null) ...[
            const Divider(),
            Text(
              booking.statusMessage!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.error,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, AppLocalizations t) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    String label = t.edit;
    if (booking.status == BookingStatus.current) label = t.cancel;
    if (booking.status == BookingStatus.ended) label = t.rate;

    return ElevatedButton(
      onPressed: onAction,
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.primary,
        shape: const StadiumBorder(),
      ),
      child: Text(
        label,
        style: theme.textTheme.bodySmall?.copyWith(
          color: colors.onPrimary,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildImage(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        url,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
        errorBuilder: (c, o, s) =>
        const Icon(Icons.image, size: 40),
      ),
    );
  }
}
