import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rent/l10n/app_localizations.dart';
import '../data/colors.dart';
import '../models/booking_model.dart';

class BookingCard extends StatelessWidget {
  final BookingModel booking;
  final VoidCallback? onEdit;
  final VoidCallback? onCancel;
  final VoidCallback? onRate; // For "Edit", "Cancel", or "Rate"

  const BookingCard({
    super.key,
    required this.booking,
    this.onEdit,
    this.onCancel,
    this.onRate,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');

    final bool isUpdate = booking.status == BookingStatus.update;

    final displayFrom = isUpdate
        ? (booking.newFromDate ?? booking.fromDate)
        : booking.fromDate;
    final displayTo = isUpdate
        ? (booking.newToDate ?? booking.toDate)
        : booking.toDate;
    final displayTotal = isUpdate
        ? (booking.newTotalPrice ?? booking.totalPrice)
        : booking.totalPrice;

    // Determine Labels
    final String labelFrom = isUpdate ? "new start date" : "from";
    final String labelTo = isUpdate ? "new end date" : "to";
    final String labelTotal = isUpdate ? "new total price" : "total price";
    final t = AppLocalizations.of(context)!; //للترجمة

    return Container(
      height: 165,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: MyColor.offWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: MyColor.deepBlue.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Left: Image ---
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  booking.property.imageUrls.isNotEmpty
                      ? booking.property.imageUrls.first
                      : '',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                    width: 120,
                    height: double.infinity,
                    color: Colors.grey,
                    child: const Icon(Icons.home, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // --- Right: Details & Buttons ---
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Buttons or Status Text
                    _buildTopActionSection(),

                    const SizedBox(height: 8),

                    // 2. DATES
                    _buildDetailRow(labelFrom, dateFormat.format(displayFrom)),
                    _buildDetailRow(
                      labelTo,
                      " : ${dateFormat.format(displayTo)}",
                    ), // Formatting to match photo "to :"

                    const SizedBox(height: 8),
                    // 3. PRICE
                    Row(
                      children: [
                        Text(
                          "\$${booking.pricePerNight.toStringAsFixed(0)}",
                          style: const TextStyle(
                            color: MyColor.deepBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Text(
                          "  per night",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "$labelTotal : ${displayTotal.toStringAsFixed(0)}\$",
                      style: const TextStyle(
                        color: MyColor.deepBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopActionSection() {
    // 1. PENDING OR CURRENT -> Show Edit & Cancel
    if (booking.status == BookingStatus.pending ||
        booking.status == BookingStatus.current) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _smallButton("edit", MyColor.deepBlue, onEdit),
          const SizedBox(width: 8),
          _smallButton("cancel", MyColor.darkRed, onCancel),
        ],
      );
    }

    // 2. ENDED -> Show Rate
    if (booking.status == BookingStatus.ended) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [_smallButton("rate", MyColor.deepBlue, onRate)],
      );
    }

    // 3. REJECTED -> Show Message
    if (booking.status == BookingStatus.rejected) {
      return const Align(
        alignment: Alignment.centerRight,
        child: Text(
          "the booking rejected",
          textAlign: TextAlign.right,
          style: TextStyle(
            color: MyColor.darkRed,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      );
    }

    // 4. CANCELED -> Show Message
    if (booking.status == BookingStatus.cancelled) {
      return Align(
        alignment: Alignment.centerRight,
        child: Text(
          "the booking cancelled at:\n${DateFormat('yyyy-MM-dd').format(DateTime.now())}",
          textAlign: TextAlign.right,
          style: TextStyle(
            color: MyColor.darkRed,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      );
    }

    // 5. UPDATE  -> Show nothing
    return const SizedBox(height: 20);
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Text(
            "$label ",
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          Text(
            value,
            style: const TextStyle(
              color: MyColor.deepBlue,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallButton(String text, Color color, VoidCallback? onTap) {
    return SizedBox(
      height: 28,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
