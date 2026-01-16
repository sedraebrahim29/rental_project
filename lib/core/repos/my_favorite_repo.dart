import 'dart:convert';
import '../../helper/secure_storage_service.dart';
import '../../models/property_model.dart';
import '../apis/my_favorite_api.dart';

class FavoriteRepo {
  final FavoriteApi favoriteApi = FavoriteApi();

  Future<List<PropertyModel>> getFavorites() async {
    final String token = await SecureStorage.getToken();

    var response = await favoriteApi.getFavorites(token);
    var responseBody = json.decode(response);

    // same factory i used in PropertyRepo
    var favorites = PropertyModel.fromListProperties(responseBody);
    return favorites;
  }
}