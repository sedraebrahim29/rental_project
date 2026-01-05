import 'dart:convert';

import '../../helper/secure_storage_service.dart';
import '../../models/booking_model.dart';

import '../apis/booking_api.dart';



class BookingRepo {

  final BookingApi _api = BookingApi();



//  fetch bookings based on the status enum

  Future<List<BookingModel>> getBookingsByStatus(BookingStatus status) async {

    String responseBody;
    final String token = await SecureStorage.getToken( );



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

    }



// Parse the JSON

    final jsonMap = json.decode(responseBody);



    final List<dynamic> list = jsonMap['data'] ?? [];



    return list.map((e) => BookingModel.fromJson(e)).toList();

  }

}