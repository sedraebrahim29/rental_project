import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:rent/helper/api.dart';
import 'package:rent/models/city_model.dart';

import 'package:rent/models/conflict_booking_model.dart';
import 'package:rent/models/governorate_model.dart';

class BookingService {
  static const baseUrl = 'http://127.0.0.1:8000/api';
  // get date
  Future<List<BookingDateModel>> getPropertyBookings({
    required int propertyId,
    required String token,
    required String lang,
  }) async {
    final response = await Api(languageCode: lang).get(
      url: '$baseUrl/bookings/getPropertyBookings/$propertyId',
      token: token,
    );
    log('hh');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return (decoded['data'] as List)
          .map((e) => BookingDateModel.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  Future<List<GovernorateModel>> getAllGovernorates(
    String token,
    String lang,
  ) async {
    final response = await Api(
      languageCode: lang,
    ).get(url: '$baseUrl/properties/allGovernorates', token: token);

    final decoded = jsonDecode(response.body);
    return (decoded['data'] as List)
        .map((e) => GovernorateModel.fromJson(e))
        .toList();
  }

  //get cities
  Future<List<CityModel>> getCitiesByGovernorate({
    required int governorateId,
    required String token,
    required String lang,
  }) async {
    final response = await Api(
      languageCode: lang,
    ).get(url: '$baseUrl/properties/allCities/$governorateId', token: token);

    final decoded = jsonDecode(response.body);
    return (decoded['data'] as List).map((e) => CityModel.fromJson(e)).toList();
  }

  // post
  Future<void> createBooking({
    required String startDate,
    required String endDate,
    required String pricePerNight,
    required String totalPrice,
    required int propertyId,
    required int governorateId,
    required int cityId,
    required String token,
    required String lang,
  }) async {
    final response = await Api(languageCode: lang).post(
      url: '$baseUrl/bookings/create',
      token: token,
      body: {
        'start_date': startDate,
        'end_date': endDate,
        'price_per_night': pricePerNight,
        'total_price': totalPrice,
        'property_id': propertyId,
        'user_governorate_id': governorateId,
        'user_city_id': cityId,
      },
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Booking failed');
    }
  }
}
