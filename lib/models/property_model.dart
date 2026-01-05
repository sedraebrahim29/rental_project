import 'dart:io';

class PropertyModel {
  final String? id; //  اختياري لأنه عند الإضافة لا يكون لدينا ID بعد
  final String ownerName;
  final String? city;
  final String? governorate;
  final String category;
  final List<String> amenities;
  final String area;
  final String price;
  final String beds;
  final String baths;
  final String address;
  final double rating;

  // نوعين من الصور
  final List<String> imageUrls;   // روابط صور (للقراءة من الـ API)
  final List<File>? localImages;  // ملفات صور (عند الإضافة من الموبايل)

  PropertyModel({
    this.id,
    required this.ownerName,
     this.city,
     this.governorate,
    required this.category,
    required this.amenities,
    required this.area,
    required this.price,
    required this.beds,
    required this.baths,
    required this.address,
  this.rating = 0.0,
    this.imageUrls = const [],
    this.localImages,
  });

  //  استقبال بيانات الـ API
  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id']?.toString(),
      ownerName: json['owner']?['name'] ?? 'Unknown',//
      city: json['city'] ?? '',
      governorate: json['governorate'] ?? '',
      category: json['category'] ?? '',
      amenities: json['amenities'] != null
          ? List<String>.from(json['amenities'])
          : [],
      area: json['area']?.toString() ?? '',
      price: json['price']?.toString() ?? '',
      beds: json['bedrooms']?.toString() ?? '',//
      baths: json['bathrooms']?.toString() ?? '',//
      address: json['address'] ?? '',

      rating: (json['rating'] ?? 0.0).toDouble(),

      imageUrls: json['images'] != null//
          ? List<String>.from(
        json['images'].map((img) => img['url']),
      )
          : [],

    );
  }

  //  إرسال البيانات للـ API
  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'governorate': governorate,
      'category': category,
      'amenities': amenities,
      'area': area,
      'price': price,
      'beds': beds,
      'baths': baths,
      'address': address,
    };
  }
}