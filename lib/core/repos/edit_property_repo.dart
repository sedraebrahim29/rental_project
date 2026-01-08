import 'dart:io';
import 'package:rent/core/constant.dart';

import '../../helper/secure_storage_service.dart';
import '../apis/edit_property_api.dart';

class EditPropertyRepo {
  final EditPropertyApi api = EditPropertyApi();

  Future<void> updateProperty(
    String id,
    Map<String, dynamic> body,
    List<File> images,
  ) async {
    final String token = await SecureStorage.getToken();
    await api.updateProperty(id, body, images, token);
  }

  Future<void> deleteProperty(String id) async {
    final String token = await SecureStorage.getToken();
    await api.deleteProperty(id, token);
  }
}
