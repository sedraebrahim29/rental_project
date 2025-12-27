

class LoginModel {
  String phone;
  String password;

  LoginModel({required this.phone, required this.password});

  factory LoginModel.fromjson(jsonData){
    return LoginModel(phone: jsonData['phone'], password: jsonData['password']);
  }
}