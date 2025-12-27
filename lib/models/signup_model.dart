class SignupModel {
  final String firstName;
  final String lastName;
  final String birthday;
  final String phone;
  final String password;
  final String passwordConfirmation;

  SignupModel({
    required this.firstName,
    required this.lastName,
    required this.birthday,
    required this.phone,
    required this.password,
    required this.passwordConfirmation,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      birthday: json['birthday'],
      phone: json['phone'],
      password: json['password'],
      passwordConfirmation: json['password_confirmation'],
    );
  }
}
