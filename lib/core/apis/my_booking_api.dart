import 'package:http/http.dart' as http;
import '../constant.dart';

class BookingApi {


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


  //  Actions

  // 1. Cancel Booking
  Future<String> cancelBooking(String bookingId, String token) async {
    return _fetchData('bookings/cancel/$bookingId', token);
  }

  // 2. Edit Booking
  Future<String> updateBooking(String bookingId, String startDate, String endDate, String token) async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/bookings/update/$bookingId"),
        headers: {
          "authorization": "Bearer $token",
          "accept": "application/json",
        },
        body: {
          "start_date": startDate,
          "end_date": endDate,
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

  // 3. Rate Booking
  Future<String> rateBooking(String bookingId, int rating, String token) async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/properties/rating"),
        headers: {
          "authorization": "Bearer $token",
          "accept": "application/json",
        },
        body: {
          "rating": rating.toString(),
           "booking_id": bookingId
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