import 'dart:convert';
import 'dart:io';
import 'package:rent/core/constant.dart';

import '../../helper/secure_storage_service.dart';
import '../apis/add_property_api.dart';

class AddPropertyRepo {
  final AddPropertyApi api = AddPropertyApi();

  Future<List<Map<String, dynamic>>> fetchData(String type, {int? id}) async {
    final String token = await SecureStorage.getToken( );
    String response;
    if (type == 'governorate') {
      response = await api.getGovernorates(token);
    } else if (type == 'city') {
      response = await api.getCities(id!,token);
    } else if (type == 'category') {
      response = await api.getCategories(token);
    } else {
      response = await api.getAmenities(token);
    }

    var jsonResponse = json.decode(response);
    // Return the list inside 'data'
    return List<Map<String, dynamic>>.from(jsonResponse['data']);
  }

  Future<void> submitProperty(
    Map<String, String> body,
    List<File> images,
  ) async {
    await api.postProperty(body, images,token);
  }
}
