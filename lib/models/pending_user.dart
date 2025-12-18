class PendingUser {
  final int id;
  final String fullName;
  final String createdAt;
  final String phone;
  final String birthDate;
  final String image;
  final String idImage;

  PendingUser({
    required this.id,
    required this.fullName,
    required this.createdAt,
    required this.phone,
    required this.birthDate,
    required this.image,
    required this.idImage,
  });

  factory PendingUser.fromJson(Map<String, dynamic> json) {
    return PendingUser(
      id: json['id'],
      fullName: json['full_name'],
      createdAt: json['created_at'],
      phone: json['phone'],
      birthDate: json['birth_date'],
      image: json['image'],
      idImage: json['ID_image'],
    );
  }
}
