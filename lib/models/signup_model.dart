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

  Map<String, String> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'birth_date': birthday,
      'phone': phone,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }
}
