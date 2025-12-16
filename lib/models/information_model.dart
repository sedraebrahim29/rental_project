import 'package:flutter/foundation.dart';

class InfoModel {
  String phone;
  String password;

  InfoModel({required this.phone, required this.password});

  factory InfoModel.fromjson(jsonData){
    return InfoModel(phone: jsonData['phone'], password: jsonData['password']);
  }
}