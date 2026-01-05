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
    Map<String, String> body,
    List<File> images,
       token
  ) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/properties"),
    );

    request.headers.addAll({
      "authorization": "Bearer $token",
      "accept": "application/json",
    });

    request.fields.addAll(body);

    for (var file in images) {
      request.files.add(
        await http.MultipartFile.fromPath('images[]', file.path),
      );
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception("Error: ${response.statusCode} ${response.body}");
    }
  }
}
