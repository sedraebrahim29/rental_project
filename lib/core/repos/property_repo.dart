import 'dart:convert';
import 'dart:developer';

import 'package:rent/core/constant.dart';

import '../../helper/secure_storage_service.dart';
import '../../models/my_properties_booking_model.dart';
import '../../models/property_model.dart';
import '../apis/property_api.dart';

class PropertyRepo {
  PropertyApi propertyApi = PropertyApi();

  // For MyProperties Screen
  Future<List<PropertyModel>> getProperties() async {
    final String token = await SecureStorage.getToken();
    print('Token from storage=> $token');
    var response = await propertyApi.getProperties(token);
    var responseBody = json.decode(response);
    var properties = PropertyModel.fromListProperties(responseBody);
    return properties;
  }

  //  For Home Screen
  Future<List<PropertyModel>> getHomeProperties() async {
    final String token = await SecureStorage.getToken();
    log('Token from storage=> $token');
    var response = await propertyApi.getAllProperties(token);
    var responseBody = json.decode(response);
    return PropertyModel.fromListProperties(responseBody);
  }

  // ---------------- NEW METHODS FOR PROPERTY BOOKING ----------------

<<<<<<< HEAD
  Future<List<PropertiesBookingModel>> getPendingBookings(
    String propertyId,
  ) async {
    var response = await propertyApi.getPropertyPendingBookings(
      propertyId,
      token,
    );
=======
//  NEW METHODS FOR PROPERTY BOOKING

  Future<List<PropertiesBookingModel>> getPendingBookings(String propertyId) async {
    var response = await propertyApi.getPropertyPendingBookings(propertyId,token);
>>>>>>> origin/ahmad
    var responseBody = json.decode(response);

    List<PropertiesBookingModel> bookings = [];
    // Access the 'data' key from your Postman response
    if (responseBody['data'] != null) {
      for (var item in responseBody['data']) {
        bookings.add(
          PropertiesBookingModel.fromJson(item, BookingStatus.pending),
        );
      }
    }
    return bookings;
  }

  Future<List<PropertiesBookingModel>> getCurrentBookings(
    String propertyId,
  ) async {
    var response = await propertyApi.getPropertyCurrentBookings(
      propertyId,
      token,
    );
    var responseBody = json.decode(response);

    List<PropertiesBookingModel> bookings = [];
    if (responseBody['data'] != null) {
      for (var item in responseBody['data']) {
        bookings.add(
          PropertiesBookingModel.fromJson(item, BookingStatus.current),
        );
      }
    }
    return bookings;
  }

  //  for Update Request
  Future<List<PropertiesBookingModel>> getUpdateRequests(
    String propertyId,
  ) async {
    return [];
  }
}

// Future<List<PropertyModel>>  postProperty(var body) async {
//   var response = await propertyApi.postProperty(json.encode(body));
//   var responseBody = json.decode(response);
//   var properties = PropertyModel.fromListProperties(responseBody);
//   return properties;
// }
