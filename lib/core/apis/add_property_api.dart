import 'dart:io';
import 'package:http/http.dart' as http;
import '../constant.dart';

class AddPropertyApi {

  Future<String> getGovernorates( token) async {
    var response = await http.get(
      Uri.parse("$baseUrl/properties/allGovernorates"),
      headers: {"authorization": "Bearer $token", "accept": "application/json"},
    );
    return response.body;
  }

  Future<String> getCities(int governorateId, token) async {
    var response = await http.get(
      Uri.parse("$baseUrl/properties/allCities/$governorateId"),
      headers: {"authorization": "Bearer $token", "accept": "application/json"},
    );
    return response.body;
  }

  Future<String> getCategories( token) async {
    var response = await http.get(
      Uri.parse("$baseUrl/properties/allCategories"),
      headers: {"authorization": "Bearer $token", "accept": "application/json"},
    );
    return response.body;
  }

  Future<String> getAmenities( token) async {
    var response = await http.get(
      Uri.parse("$baseUrl/properties/allAmenities"),
      headers: {"authorization": "Bearer $token", "accept": "application/json"},
    );
    return response.body;
  }

  Future<String> postProperty(
      Map<String, dynamic> body, // Changed to dynamic for Lists
      List<File> images,
      String token
      ) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseUrl/properties"),
      );

      request.headers.addAll({
        "authorization": "Bearer $token",
        "accept": "application/json",
      });

      // 1. Handle Body Fields (Strings and Lists)
      body.forEach((key, value) {
        if (value is List) {
          // If it's a list (like amenities), add as array items: amenities[0], amenities[1]
          for (int i = 0; i < value.length; i++) {
            request.fields['$key[$i]'] = value[i].toString();
          }
        } else {
          request.fields[key] = value.toString();
        }
      });

      // 2. Handle Images
      for (var file in images) {
        request.files.add(
          await http.MultipartFile.fromPath('images[]', file.path),
        );
      }

      // 3. Send Request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else {
        throw Exception("Error: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      // Rethrow allows the Repo/Cubit to handle the error (show toast, etc.)
      rethrow;
    }
  }
}
