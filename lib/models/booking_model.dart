import 'property_model.dart';

// Enum to represent the 5 buttons
enum BookingStatus { pending, current, canceled, rejected, ended }

class BookingModel {
  final String id;
  final PropertyModel property; // We need this for the Image & Owner Name
  final DateTime fromDate;
  final DateTime toDate;
  final double pricePerNight;
  final double totalPrice;
  final BookingStatus status;
  final String? statusMessage; // For specific messages like "rejected on..."

  BookingModel({
    required this.id,
    required this.property,
    required this.fromDate,
    required this.toDate,
    required this.pricePerNight,
    required this.totalPrice,
    required this.status,
    this.statusMessage,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'].toString(),
      // Assumes 'property' object exists inside the booking JSON to get the image/owner
      property: PropertyModel.fromJson(json['property'] ?? {}),

      // Parse dates from API (e.g., "2025-01-01")
      fromDate: DateTime.parse(json['start_date']),
      toDate: DateTime.parse(json['end_date']),

      // Parse numbers safely
      pricePerNight: double.tryParse(json['price_per_night'].toString()) ?? 0.0,
      totalPrice: double.tryParse(json['total_price'].toString()) ?? 0.0,

      // Map string status from API to Enum
      status: _mapStatus(json['status']),

      // Optional message field
      statusMessage: json['message'],
    );
  }

  static BookingStatus _mapStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return BookingStatus.pending;
      case 'current':
        return BookingStatus.current;
      case 'canceled':
        return BookingStatus.canceled;
      case 'rejected':
        return BookingStatus.rejected;
      case 'ended':
        return BookingStatus.ended;
      default:
        return BookingStatus.pending;
    }
  }
}
