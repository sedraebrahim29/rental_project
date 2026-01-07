import 'dart:convert';
import 'dart:io';

import '../../helper/secure_storage_service.dart';
import '../apis/add_property_api.dart';

class AddPropertyRepo {
  final AddPropertyApi api = AddPropertyApi();

  /// 1. Get Governorates
  Future<List<Map<String, dynamic>>> getGovernorates() async {
    final String token = await SecureStorage.getToken();
    final response = await api.getGovernorates(token);

    var jsonResponse = json.decode(response);
    return List<Map<String, dynamic>>.from(jsonResponse['data']);
  }

  /// 2. Get Cities
  Future<List<Map<String, dynamic>>> getCities(int governorateId) async {
    final String token = await SecureStorage.getToken();
    final response = await api.getCities(governorateId, token);

    var jsonResponse = json.decode(response);
    return List<Map<String, dynamic>>.from(jsonResponse['data']);
  }

  /// 3. Get Categories
  Future<List<Map<String, dynamic>>> getCategories() async {
    final String token = await SecureStorage.getToken();
    final response = await api.getCategories(token);

    var jsonResponse = json.decode(response);
    return List<Map<String, dynamic>>.from(jsonResponse['data']);
  }

  /// 4. Get Amenities
  Future<List<Map<String, dynamic>>> getAmenities() async {
    final String token = await SecureStorage.getToken();
    final response = await api.getAmenities(token);

    var jsonResponse = json.decode(response);
    return List<Map<String, dynamic>>.from(jsonResponse['data']);
  }

  /// 5. Submit Property
  Future<void> submitProperty(
      Map<String, String> body,
      List<File> images,
      ) async {
    final String token = await SecureStorage.getToken();
    await api.postProperty(body, images, token);
  }
}