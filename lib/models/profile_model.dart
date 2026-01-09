class ProfileModel {
  final int id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String phone;
  final String birthDate;
  final int balance;
  final int propertiesCount;
  final String image;

  ProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.phone,
    required this.birthDate,
    required this.balance,
    required this.propertiesCount,
    required this.image,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      fullName: json['full_name'] ?? '',
      phone: json['phone'] ?? '',
      birthDate: json['birth_date'] ?? '',
      balance: json['current_balance'] ?? 0,
      propertiesCount: json['properties_count'] ?? 0,
      image: json['image'] ?? '',
    );
  }
}
