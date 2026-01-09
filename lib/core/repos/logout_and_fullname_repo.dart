import '../../helper/secure_storage_service.dart';
import '../apis/logout_and_fullname_api.dart';


class LogoutRepo {
  final LogoutApi _api = LogoutApi();

  Future<void> logout() async {
    try {
      final String token = await SecureStorage.getToken();

      if (token.isNotEmpty) {
        await _api.logout(token);
      }
    } catch (e) {
      print("Logout API error: $e");

    } finally {

      await SecureStorage.removeToken();
    }
  }
}

class UserRepo {
  final UserApi _api = UserApi();

  Future<String> getUserName() async {
    final String token = await SecureStorage.getToken();
    return await _api.getUserName(token);
  }
}