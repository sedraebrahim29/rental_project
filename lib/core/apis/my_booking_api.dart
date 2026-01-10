import 'package:http/http.dart' as http;
import '../constant.dart';

class BookingApi {

  // Helper method to handle requests
  Future<String> _fetchData(String endpoint, String token) async {
    try {
      final uri = Uri.parse("$baseUrl/$endpoint");
      var response = await http.get(
        uri,
        headers: {
          "authorization": "Bearer $token",
          "accept": "application/json",
        },
      );

      if (response.statusCode != 200) {
        throw Exception("Error ${response.statusCode}: ${response.body}");
      }
      return response.body;
    } catch (e) {
      rethrow;
    }
  }

  // Define the specific calls based on your routes
  Future<String> getPendingBookings(String token) async =>
      _fetchData('bookings/getUserPendingBookings', token);

  Future<String> getCurrentBookings(String token) async =>
      _fetchData('bookings/getUserCurrentBookings', token);

  Future<String> getUpdateBookings(String token) async =>
      _fetchData('bookings/getUserUpdateBookings', token);

  Future<String> getEndedBookings(String token) async =>
      _fetchData('bookings/getUserEndedBookings', token);

  Future<String> getCanceledBookings(String token) async =>
      _fetchData('bookings/getUserCanceledBookings', token);

  Future<String> getRejectedBookings(String token) async =>
      _fetchData('bookings/getUserRejectedBookings', token);


  // --- NEW METHODS (Actions) ---

  // 1. Cancel Booking (GET based on your screenshot)
  Future<String> cancelBooking(String bookingId, String token) async {
    return _fetchData('bookings/cancel/$bookingId', token);
  }

  // 2. Edit/Update Booking (POST based on your screenshot)
  Future<String> updateBooking(String bookingId, String startDate, String endDate, String token) async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/bookings/update/$bookingId"),
        headers: {
          "authorization": "Bearer $token",
          "accept": "application/json",
        },
        body: {
          "new_start_date": startDate,
          "new_end_date": endDate,
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception("Update Error ${response.statusCode}: ${response.body}");
      }
      return response.body;
    } catch (e) {
      rethrow;
    }
  }

  // 3. Rate Booking (Assuming POST based on pattern)
  Future<String> rateBooking(String bookingId, double rating, String token) async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/properties/rating"), // Updated endpoint based on your screenshot image_431671.png
        headers: {
          "authorization": "Bearer $token",
          "accept": "application/json",
        },
        body: {
          "rating": rating.toString(),
          // You might need to send bookingId or propertyId depending on backend requirement for this endpoint
          // "booking_id": bookingId
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception("Rate Error ${response.statusCode}: ${response.body}");
      }
      return response.body;
    } catch (e) {
      rethrow;
    }
  }
}