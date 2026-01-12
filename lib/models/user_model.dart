import 'dart:developer';

class UserModel {
  final String name;
  final String image;
  final String token;
  UserModel({required this.name, required this.image, required this.token});
  factory UserModel.fromJson(List<dynamic> json) {
    log(json[0]['name']);
    return UserModel(
      name: json[0]['name'] ?? '',
      image: json[0]['image'] ?? '',
      token: json[1] ?? '',
    );
  }
}
