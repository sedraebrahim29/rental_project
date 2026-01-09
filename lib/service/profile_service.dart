import 'dart:convert';
import 'package:rent/helper/api.dart';
import 'package:rent/models/profile_model.dart';

class ProfileService {
  Future<ProfileModel> getProfile({required String token}) async {
    final response = await Api().get(
      url: 'http://127.0.0.1:8000/api/users/showProfile',
      token: token,
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return ProfileModel.fromJson(decoded['data']);
    } else {
      throw Exception('Failed to load profile');
    }
  }
}
