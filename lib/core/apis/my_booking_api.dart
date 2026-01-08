import 'package:http/http.dart' as http;

import '../constant.dart';



class BookingApi {




  Future<String> _fetchData(String endpoint ) async {

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



// Define the 5 specific calls based on your routes

  Future<String> getPendingBookings( token ) async => _fetchData('bookings/getUserPendingBookings');



  Future<String> getCurrentBookings(token) async => _fetchData('bookings/getUserCurrentBookings');



  Future<String> getEndedBookings( token) async => _fetchData('bookings/getUserEndedBookings');



  Future<String> getCanceledBookings( token) async => _fetchData('bookings/getUserCanceledBookings');



  Future<String> getRejectedBookings( token) async => _fetchData('bookings/getUserRejectedBookings');

}