import 'dart:convert';

import 'package:rent/helper/api.dart';

import 'package:rent/models/conflict_booking_model.dart';

class BookingService {
  static const baseUrl = 'http://127.0.0.1:8000/api';

  Future<List<BookingDateModel>> getPropertyBookings({
    required int propertyId,
    required String token,
  }) async {
    final response = await Api().get(
      url: '$baseUrl/bookings/getPropertyBookings/$propertyId',
      token: token,
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return (decoded['data'] as List)
          .map((e) => BookingDateModel.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  Future<void> createBooking({
    required String startDate,
    required String endDate,
    required String pricePerNight,
    required String totalPrice,
    required int propertyId,
    required int governorateId,
    required int cityId,
    required String token,
  }) async {
    final response = await Api().post(
      url: '$baseUrl/bookings/create',
      token: token,
      body: {
        'start_date': startDate,
        'end_date': endDate,
        'price_per_night': pricePerNight,
        'total_price': totalPrice,
        'property_id': propertyId,
        'governorate_id': governorateId,
        'city_id': cityId,
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Booking failed');
    }
  }
}
