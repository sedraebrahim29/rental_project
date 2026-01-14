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

    if (json['old'] != null && json['new'] != null) {
      final oldData = json['old'];
      final newData = json['new'];

      return BookingModel(

        id: (json['booking_id'] ?? json['id']).toString(),

        property: PropertyModel.fromJson(json['property'] ?? {}),

        // Old dates (Current )
        fromDate: DateTime.parse(oldData['start_date']),
        toDate: DateTime.parse(oldData['end_date']),
        pricePerNight:
            double.tryParse(oldData['price_per_night'].toString()) ?? 0.0,
        totalPrice: double.tryParse(oldData['total_price'].toString()) ?? 0.0,

        status: BookingStatus.update,
        statusMessage: json['message'],
        // or null

        // New dates ( Update)
        newFromDate: DateTime.parse(newData['start_date']),
        newToDate: DateTime.parse(newData['end_date']),
        newTotalPrice:
            double.tryParse(newData['total_price'].toString()) ?? 0.0,
      );
    }

    //  (For Pending, Current, etc.)
    final updateData = json['update_request'];

    // Logic to detect if a normal booking has a pending update attached
    BookingStatus finalStatus;
    if (updateData != null) {
      finalStatus = BookingStatus.update;
    } else {
      finalStatus = _mapStatus(json['status']);
    }

    return BookingModel(
      id: json['id'].toString(),
      property: PropertyModel.fromJson(json['property'] ?? {}),
      fromDate: DateTime.parse(json['start_date']),
      toDate: DateTime.parse(json['end_date']),
      pricePerNight: double.tryParse(json['price_per_night'].toString()) ?? 0.0,
      totalPrice: double.tryParse(json['total_price'].toString()) ?? 0.0,

      status: finalStatus,
      statusMessage: json['message'],

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

// factory BookingModel.fromJson(Map<String, dynamic> json) {
//   final updateData = json['update_request'];
//
//   return BookingModel(
//     id: json['id'].toString(),
//
//     property: PropertyModel.fromJson(json['property'] ?? {}),
//
//     fromDate: DateTime.parse(json['start_date']),
//     toDate: DateTime.parse(json['end_date']),
//
//     pricePerNight: double.tryParse(json['price_per_night'].toString()) ?? 0.0,
//     totalPrice: double.tryParse(json['total_price'].toString()) ?? 0.0,
//
//     status: _mapStatus(json['status']),
//     statusMessage: json['message'],
//
//     // 2. Parse Update Fields
//     newFromDate: (updateData != null && updateData['new_start_date'] != null)
//         ? DateTime.parse(updateData['new_start_date'])
//         : null,
//     newToDate: (updateData != null && updateData['new_end_date'] != null)
//         ? DateTime.parse(updateData['new_end_date'])
//         : null,
//     newTotalPrice:
//         (updateData != null && updateData['new_total_price'] != null)
//         ? double.tryParse(updateData['new_total_price'].toString())
//         : null,
//   );
// }
