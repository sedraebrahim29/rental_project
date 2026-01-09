import 'package:flutter/material.dart';
import '../data/colors.dart';
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColor.offWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // Fixed deprecated withOpacity
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Guest Name
          Text(
            booking.guestName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: MyColor.deepBlue,
            ),
          ),
          const SizedBox(height: 12),

          if (booking.status == BookingStatus.updateRequest)
            _buildUpdateRequestInfo()
          else
            _buildStandardInfo(),

          const SizedBox(height: 16),

          // Buttons Row
          if (booking.status != BookingStatus.current)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton('accept', MyColor.deepBlue, onAccept),
              const SizedBox(width: 16),
              _buildActionButton('reject', MyColor.darkRed, onReject),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStandardInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _textRow("from:", booking.startDate),
            const SizedBox(height: 4),
            _textRow("\$${booking.pricePerNight}", "per night"),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _textRow("to:", booking.endDate),
            const SizedBox(height: 4),
            Text(
              "total price : ${booking.totalPrice}\$",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: MyColor.deepBlue,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUpdateRequestInfo() {
    return Column(
      children: [
        _arrowRow("from:", booking.startDate, booking.newStartDate),
        const SizedBox(height: 8),
        _arrowRow("to:", booking.endDate, booking.newEndDate),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "total price : ${booking.totalPrice}\$",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: MyColor.deepBlue),
            ),
            const Icon(Icons.arrow_forward, size: 16, color: MyColor.deepBlue),
            Text(
              "new total price : ${booking.newTotalPrice}\$",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: MyColor.deepBlue),
            ),
          ],
        )
      ],
    );
  }

  Widget _textRow(String label, String value) {
    return Row(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(width: 4),
        Text(value, style: const TextStyle(color: MyColor.deepBlue, fontSize: 12)),
      ],
    );
  }

  Widget _arrowRow(String label, String oldVal, String? newVal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _textRow(label, oldVal)),
        const Icon(Icons.arrow_forward, size: 16, color: MyColor.deepBlue),
        Expanded(child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: _textRow(label, newVal ?? "N/A"),
        )),
      ],
    );
  }

  Widget _buildActionButton(String label, Color color, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 0),
        minimumSize: const Size(100, 36),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 13),
      ),
    );
  }
}