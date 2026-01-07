import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../models/property_model.dart';
import '../constant.dart';

class EditPropertyApi {

  // 1. GET Property (To show current data)
  Future<PropertyModel> getPropertyById(String id, String token) async {
    try {
      var response = await http.get(
        Uri.parse("$baseUrl/properties/$id"),
        headers: {
          "authorization": "Bearer $token",
          "accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return PropertyModel.fromJson(data['data']);
      } else {
        throw Exception("Get Error: ${response.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }


  // Update property
  Future<String> updateProperty(
      String propertyId,
      Map<String, dynamic> body,
      List<File> newImages,
       token
      ) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/properties/$propertyId"),
    );

    request.headers.addAll({
      "authorization": "Bearer $token",
      "accept": "application/json",
    });

    // force method to PUT while using POST for multipart
    request.fields['_method'] = 'PUT';
    // --- FIX it : to handle Lists (Amenities)
    body.forEach((key, value) {
      if (value is List) {
        // If it's a list (like amenities), we add them as array keys: amenities[0], amenities[1]
        for (int i = 0; i < value.length; i++) {
          request.fields['$key[$i]'] = value[i].toString();
        }
      } else {
        // Standard string fields
        request.fields[key] = value.toString();
      }
    });

    for (var file in newImages) {
      request.files.add(
        await http.MultipartFile.fromPath('images[]', file.path),
      );
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Update Error: ${response.statusCode}");
    }
  }

  // Delete property
  Future<void> deleteProperty(String propertyId , token) async {
    var response = await http.delete(
      Uri.parse("$baseUrl/properties/$propertyId"),
      headers: {
        "authorization": "Bearer $token",
        "accept": "application/json",
      },
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Delete Error: ${response.statusCode}");
    }
  }
}