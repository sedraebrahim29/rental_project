enum BookingStatus { pending, current, updateRequest }

class PropertiesBookingModel {
  final String id;
  final String guestName;
  final String startDate;
  final String endDate;
  final double pricePerNight;
  final double totalPrice;
  final BookingStatus status;

  // Fields for "Update Request"
  final String? bookingId;
  final String? newStartDate;
  final String? newEndDate;
  final double? newTotalPrice;

  PropertiesBookingModel({
    required this.id,
    required this.guestName,
    required this.startDate,
    required this.endDate,
    required this.pricePerNight,
    required this.totalPrice,
    required this.status,
    this.bookingId,
    this.newStartDate,
    this.newEndDate,
    this.newTotalPrice,
  });

  factory PropertiesBookingModel.fromJson(
    Map<String, dynamic> json,
    BookingStatus forcedStatus,
  ) {
    // LOGIC FOR UPDATE REQUEST (Nested JSON structure based on Postman)
    if (forcedStatus == BookingStatus.updateRequest) {
      final oldData = json['old'] ?? {};
      final newData = json['new'] ?? {};

      return PropertiesBookingModel(
        id: json['booking_id']?.toString() ?? '',
        // Note: The Update API screenshot didn't show tenant name, defaulting to 'Guest' or use 'booking_id'
        guestName: json['tenant'] ?? 'Guest',

        // Map 'Old' Data
        startDate: oldData['start_date'] ?? '',
        endDate: oldData['end_date'] ?? '',
        pricePerNight:
            double.tryParse(oldData['price_per_night']?.toString() ?? '0') ??
            0.0,
        totalPrice:
            double.tryParse(oldData['total_price']?.toString() ?? '0') ?? 0.0,

        status: forcedStatus,

        // Map 'New' Data
        //bookingId: json['booking_id'],
        newStartDate: newData['start_date'],
        newEndDate: newData['end_date'],
        newTotalPrice: newData['total_price'] != null
            ? double.tryParse(newData['total_price'].toString())
            : null,
      );
    }
    // LOGIC FOR PENDING & CURRENT (Standard Flat JSON)
    else {
      return PropertiesBookingModel(
        id: json['id']?.toString() ?? '',
        guestName: json['tenant'] ?? 'Unknown',
        startDate: json['start_date'] ?? '',
        endDate: json['end_date'] ?? '',
        pricePerNight:
            double.tryParse(json['price_per_night']?.toString() ?? '0') ?? 0.0,
        totalPrice:
            double.tryParse(json['total_price']?.toString() ?? '0') ?? 0.0,
        status: forcedStatus,
        newStartDate: null,
        newEndDate: null,
        newTotalPrice: null,
      );
    }
  }
}
