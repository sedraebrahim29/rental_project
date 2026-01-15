import 'package:http/http.dart' as http;
import 'package:rent/core/constant.dart';

class FavoriteApi {
  Future<String> getFavorites(String token) async {
    try {
      var response = await http.get(
        Uri.parse("$baseUrl/myfavourite"),
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
