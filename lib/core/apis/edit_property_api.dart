import 'dart:io';
import 'package:http/http.dart' as http;
import '../constant.dart';

class EditPropertyApi {
  // Update property
  Future<String> updateProperty(
      String propertyId,
      Map<String, String> body,
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
    request.fields.addAll(body);

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