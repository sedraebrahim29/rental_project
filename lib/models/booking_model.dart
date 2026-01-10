import 'property_model.dart';

// Enum to represent the statuses
enum BookingStatus { pending, current, update, canceled, rejected, ended }

class BookingModel {
  final String id;
  final PropertyModel property;
  final DateTime fromDate;
  final DateTime toDate;
  final double pricePerNight;
  final double totalPrice;
  final BookingStatus status;
  final String? statusMessage;

  // Update  Fields
  final DateTime? newFromDate;
  final DateTime? newToDate;
  final double? newTotalPrice;

  BookingModel({
    required this.id,
    required this.property,
    required this.fromDate,
    required this.toDate,
    required this.pricePerNight,
    required this.totalPrice,
    required this.status,
    this.statusMessage,
    this.newFromDate,
    this.newToDate,
    this.newTotalPrice,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    final updateData = json['update_request'];

    return BookingModel(
      id: json['id'].toString(),

      property: PropertyModel.fromJson(json['property'] ?? {}),

      fromDate: DateTime.parse(json['start_date']),
      toDate: DateTime.parse(json['end_date']),

      pricePerNight: double.tryParse(json['price_per_night'].toString()) ?? 0.0,
      totalPrice: double.tryParse(json['total_price'].toString()) ?? 0.0,

      status: _mapStatus(json['status']),
      statusMessage: json['message'],

      // 2. Parse Update Fields
      newFromDate: (updateData != null && updateData['new_start_date'] != null)
          ? DateTime.parse(updateData['new_start_date'])
          : null,
      newToDate: (updateData != null && updateData['new_end_date'] != null)
          ? DateTime.parse(updateData['new_end_date'])
          : null,
      newTotalPrice:
          (updateData != null && updateData['new_total_price'] != null)
          ? double.tryParse(updateData['new_total_price'].toString())
          : null,
    );
  }

  static BookingStatus _mapStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return BookingStatus.pending;
      case 'approved':
        return BookingStatus.current;
      case 'current':
        return BookingStatus.current;
      case 'update':
        return BookingStatus.update;
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
