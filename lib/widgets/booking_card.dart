import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/colors.dart';
import '../models/booking_model.dart';

class BookingCard extends StatelessWidget {
  final BookingModel booking;
  final VoidCallback? onAction; // For "Edit", "Cancel", or "Rate"

  const BookingCard({super.key, required this.booking, this.onAction});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd-MM-yyyy');

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: MyColor.offWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: MyColor.deepBlue.withOpacity(0.3)),
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
                    Text(booking.property.ownerName, style: const TextStyle(fontWeight: FontWeight.bold, color: MyColor.deepBlue)),
                    Text("From: ${dateFormat.format(booking.fromDate)}", style: const TextStyle(fontSize: 12)),
                    Text("To: ${dateFormat.format(booking.toDate)}", style: const TextStyle(fontSize: 12)),
                    Text("Total: \$${booking.totalPrice}", style: const TextStyle(fontWeight: FontWeight.bold, color: MyColor.darkRed)),
                  ],
                ),
              ),
              _buildActionButton(),
            ],
          ),
          if (booking.statusMessage != null) ...[
            const Divider(),
            Text(booking.statusMessage!, style: const TextStyle(color: MyColor.darkRed, fontWeight: FontWeight.w500, fontSize: 13)),
          ]
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    String label = "Edit";
    if (booking.status == BookingStatus.current) label = "Cancel";
    if (booking.status == BookingStatus.ended) label = "Rate";

    return ElevatedButton(
      onPressed: onAction,
      style: ElevatedButton.styleFrom(backgroundColor: MyColor.deepBlue, shape: StadiumBorder()),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 11)),
    );
  }

  Widget _buildImage(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(url, width: 80, height: 80, fit: BoxFit.cover, errorBuilder: (c, o, s) => Icon(Icons.image)),
    );
  }
}