import 'dart:io';

import '../../helper/secure_storage_service.dart';
import '../../models/property_model.dart';
import '../apis/edit_property_api.dart';

class EditPropertyRepo {
  final EditPropertyApi api = EditPropertyApi();


  // 1. GET Property implementation
  Future<PropertyModel> getPropertyById(String id) async {
    final String token = await SecureStorage.getToken();

    return await api.getPropertyById(id, token);
  }


  Future<void> updateProperty(String id, Map<String, dynamic> body, List<File> images) async {
    final String token = await SecureStorage.getToken( );
    await api.updateProperty(id, body, images,token);
  }

  Future<void> deleteProperty(String id) async {
    final String token = await SecureStorage.getToken( );
    await api.deleteProperty(id,token);
  }
}