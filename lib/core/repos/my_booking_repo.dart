import 'dart:convert';
import '../../helper/secure_storage_service.dart';
import '../../models/booking_model.dart';
import '../apis/my_booking_api.dart'; // Ensure correct import path

class BookingRepo {
  final BookingApi _api = BookingApi();

  Future<List<BookingModel>> getBookingsByStatus(BookingStatus status) async {
    String responseBody = "";
    final String token = await SecureStorage.getToken();

    // Switch on the status to call the correct endpoint
    switch (status) {
      case BookingStatus.pending:
        responseBody = await _api.getPendingBookings(token);
        break;
      case BookingStatus.current:
        responseBody = await _api.getCurrentBookings(token);
        break;
      case BookingStatus.ended:
        responseBody = await _api.getEndedBookings(token);
        break;
      case BookingStatus.canceled:
        responseBody = await _api.getCanceledBookings(token);
        break;
      case BookingStatus.rejected:
        responseBody = await _api.getRejectedBookings(token);
        break;
      case BookingStatus.update:
        responseBody = await _api.getUpdateBookings(token);
        break;
    }

    if (responseBody.isEmpty) return [];

    // Parse the JSON
    final jsonMap = json.decode(responseBody);
    final List<dynamic> list = jsonMap['data'] ?? [];

    return list.map((e) => BookingModel.fromJson(e)).toList();
  }

  // --- NEW ACTIONS ---

  // 1. Cancel
  Future<void> cancelBooking(String bookingId) async {
    final String token = await SecureStorage.getToken();
    await _api.cancelBooking(bookingId, token);
  }

  // 2. Edit (Update Dates)
  Future<void> updateBooking(String bookingId, DateTime newStart, DateTime newEnd) async {
    final String token = await SecureStorage.getToken();
    // Format dates as string (YYYY-MM-DD) for the API
    String startStr = "${newStart.year}-${newStart.month}-${newStart.day}";
    String endStr = "${newEnd.year}-${newEnd.month}-${newEnd.day}";

    await _api.updateBooking(bookingId, startStr, endStr, token);
  }

  // 3. Rate
  Future<void> rateBooking(String bookingId, int rating) async {
    final String token = await SecureStorage.getToken();
    await _api.rateBooking(bookingId, rating, token);
  }
}