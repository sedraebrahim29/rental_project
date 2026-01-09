class AmenityModel {
  final int id;
  final String name;

  AmenityModel({required this.id, required this.name});

  factory AmenityModel.fromJson(Map<String, dynamic> json) {
    return AmenityModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
