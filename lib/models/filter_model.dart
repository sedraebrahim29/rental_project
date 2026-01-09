class FilteredPropertyModel {
  final int id;
  final int price;
  final int area;
  final String category;
  final String governorate;
  final String city;
  final double rating;
  final String ownerName;
  final String image;
  final String createdAt;

  FilteredPropertyModel({
    required this.id,
    required this.price,
    required this.area,
    required this.category,
    required this.governorate,
    required this.city,
    required this.rating,
    required this.ownerName,
    required this.image,
    required this.createdAt,
  });

  factory FilteredPropertyModel.fromJson(Map<String, dynamic> json) {
    return FilteredPropertyModel(
      id: json['id'],
      price: json['price'],
      area: json['area'],
      category: json['category'] ?? '',
      governorate: json['governorate'] ?? '',
      city: json['city'] ?? '',
      rating: json['rating'] == null
          ? 0.0
          : double.tryParse(json['rating'].toString()) ?? 0.0,
      ownerName: json['owner']?['name'] ?? '',
      image: json['image'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  static List<FilteredPropertyModel> fromList(dynamic data) {
    return List<FilteredPropertyModel>.from(
      (data as List).map((e) => FilteredPropertyModel.fromJson(e)),
    );
  }
}
