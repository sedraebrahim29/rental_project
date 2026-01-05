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
    this.newStartDate,
    this.newEndDate,
    this.newTotalPrice,
  });

  factory PropertiesBookingModel.fromJson(Map<String, dynamic> json, BookingStatus forcedStatus) {
    return PropertiesBookingModel(
      id: json['id']?.toString() ?? '',
      guestName: json['tenant'] ?? 'Unknown', // Mapped from 'tenant'
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      pricePerNight: double.tryParse(json['price_per_night']?.toString() ?? '0') ?? 0.0,
      totalPrice: double.tryParse(json['total_price']?.toString() ?? '0') ?? 0.0,
      status: forcedStatus, // We assign status based on which API endpoint we called

      // These will be null for standard bookings until the Update Request API is ready
      newStartDate: json['new_start_date'],
      newEndDate: json['new_end_date'],
      newTotalPrice: json['new_total_price'] != null
          ? double.tryParse(json['new_total_price'].toString())
          : null,
    );
  }
}