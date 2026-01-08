import 'package:http/http.dart' as http;
import 'package:rent/core/constant.dart';

class PropertyApi {
  // 1. Fetch User's Properties for MyProperties Screen
  Future<String> getProperties( token) async {
    try {
      var response = await http.get(
        Uri.parse("$baseUrl/properties/myProperties"),
        headers: {
          "authorization": "Bearer $token",
          "accept":"application/json",

        },
      );
      if (response.statusCode != 200) {
        throw Exception("${response.statusCode} , ${response.body}");
      }
      return response.body;
    } catch (e) {
      rethrow;
    }
  }


  // 2. Fetch All Properties for Home Screen
  Future<String> getAllProperties( token) async {
    try {
      var response = await http.get(
        Uri.parse("$baseUrl/properties"), //
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

  // 3. Fetch Pending Bookings
  Future<String> getPropertyPendingBookings(String propertyId ,token) async {
    try {
      var response = await http.get(
        Uri.parse("$baseUrl/bookings/getPropertyPendingBookings/$propertyId"),
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

  // 4. Fetch Current Bookings
  Future<String> getPropertyCurrentBookings(String propertyId, token) async {
    try {
      var response = await http.get(
        Uri.parse("$baseUrl/bookings/getPropertyCurrentBookings/$propertyId"),
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
  // Fetch Updated Bookings
  Future<String> getPropertyUpdatedBookings(String bookingId, String token) async {
    try {
      var response = await http.get(
        Uri.parse("$baseUrl/bookings/getPropertyUpdatedBookings/$bookingId"),
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

  // 5. Accept Booking
  Future<String> approveBooking(String bookingId, String token) async {
    try {
      var response = await http.get(
        Uri.parse("$baseUrl/bookings/approve/$bookingId"),
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

  // 6. Reject Booking
  Future<String> rejectBooking(String bookingId, String token) async {
    try {
      var response = await http.get(
        Uri.parse("$baseUrl/bookings/reject/$bookingId"),
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

}







// Future<String> postProperty(var body) async {
//   try {
//     var response = await http.post(
//       Uri.parse("$baseUrl/properties"),
//       headers: {
//         "authorization": "Bearer $token",
//         "accept":"application/json",
//       "content-type":"application/json",
//       },
//       body: body
//     );
//     if (response.statusCode != 200) {
//       throw Exception("${response.statusCode} , ${response.body}");
//     }
//     return response.body;
//   } catch (e) {
//     rethrow;
//   }
// }