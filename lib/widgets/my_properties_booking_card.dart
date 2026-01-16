import 'package:flutter/material.dart';
import 'package:rent/l10n/app_localizations.dart';
import '../models/my_properties_booking_model.dart';

class BookingCard extends StatelessWidget {
  final PropertiesBookingModel booking;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const BookingCard({
    super.key,
    required this.booking,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color:colors.outline.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Guest Name
          Text(
            booking.guestName,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colors.primary,
            ),
          ),
          const SizedBox(height: 12),

          // Details Section
          if (booking.status == BookingStatus.updateRequest)
            _buildUpdateRequestInfo(context)
          else
            _buildStandardInfo(context),

          const SizedBox(height: 16),

          // Buttons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(context, t.accept, colors.primary, onAccept),
              const SizedBox(width: 16),
              _buildActionButton(context, t.rejected, colors.error, onReject),
            ],
          ),
        ],
      ),
    );
  }

  // ---------- Pending / Current ----------
  Widget _buildStandardInfo(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _textRow(context, "from:", booking.startDate),
            const SizedBox(height: 4),
            _textRow(context, "\$${booking.pricePerNight}", "per night"),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _textRow(context, "to:", booking.endDate),
            const SizedBox(height: 4),
            Text(
              "total price : ${booking.totalPrice}\$",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ---------- Update Request ----------
  Widget _buildUpdateRequestInfo(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      children: [
        _arrowRow(context, "from:", booking.startDate, booking.newStartDate),
        const SizedBox(height: 8),
        _arrowRow(context, "to:", booking.endDate, booking.newEndDate),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "total price : ${booking.totalPrice}\$",
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.primary,
              ),
            ),
            Icon(Icons.arrow_forward, size: 16, color: colors.primary),
            Text(
              "new total price : ${booking.newTotalPrice}\$",
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.primary,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _textRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Row(
      children: [
        Text(label, style: theme.textTheme.bodySmall),
        const SizedBox(width: 4),
        Text(
          value,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _arrowRow(BuildContext context, String label, String oldVal, String? newVal) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _textRow(context, label, oldVal)),
        Icon(Icons.arrow_forward, size: 16, color: colors.primary),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: _textRow(context, label, newVal ?? "N/A"),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
      BuildContext context,
      String label,
      Color color,
      VoidCallback onTap,
      ) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 32),
        minimumSize: const Size(100, 36),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
