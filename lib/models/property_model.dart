import 'dart:io';

import '../core/constant.dart';

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
  bool? isFavorite;

  // نوعين من الصور
  final List<String> imageUrls; // روابط صور (للقراءة من الـ API)
  final List<File>? localImages; // ملفات صور (عند الإضافة من الموبايل)

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
    this.isFavorite,
  });

  factory PropertyModel.init() {
    return PropertyModel(
      ownerName: '',
      city: '',
      governorate: '',
      category: '',
      amenities: [],
      area: '',
      price: '',
      beds: '',
      baths: '',
      address: '',
    );
  }

  static List<PropertyModel> fromListProperties(Map<String, dynamic> json) {
    List<PropertyModel> properties = [];
    List jsonData = [...json["data"]];

    for (int i = 0; i < jsonData.length; i++) {
      PropertyModel propertyModel = PropertyModel.fromJson(jsonData[i]);
      properties.add(propertyModel);
    }

    return properties;
  }

  //  استقبال بيانات الـ API
  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id']?.toString(),

      ownerName: json['owner']?['name'] ?? 'Unknown',
      // Nested in 'owner' object
      city: json['city'] ?? '',
      governorate: json['governorate'] ?? '',

      category: json['category'] ?? '',
      amenities: json['amenities'] != null
          ? List<String>.from(json['amenities'])
          : [],
      area: json['area']?.toString() ?? '',
      price: json['price']?.toString() ?? '',

      beds: json['bedrooms']?.toString() ?? '',
      // Match API key 'bedrooms'
      baths: json['bathrooms']?.toString() ?? '',
      // Match API key 'bathrooms'
      address: json['address'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),

      // --- FIX STARTS HERE ---
      imageUrls: _parseImages(json),
      isFavorite: json['is_favorite'] ?? false,
    );
  }

  // FUNCTION TO FIX THE BUG IN IMAGES ---
  static List<String> _parseImages(Map<String, dynamic> json) {
    List<String> rawUrls = [];

    // Case 1: API sends 'images' (List of objects or strings)
    if (json['images'] != null && json['images'] is List) {
      for (var item in json['images']) {
        if (item is String) {
          rawUrls.add(item);
        } else if (item is Map && item.containsKey('url')) {
          rawUrls.add(item['url'].toString());
        }
      }
    }
    // Case 2: API sends 'image' (Singular String) - AS SEEN IN YOUR SCREENSHOT
    else if (json['image'] != null && json['image'] is String) {
      String singleImage = json['image'];
      if (singleImage.isNotEmpty) {
        rawUrls.add(singleImage);
      }
    }

    // Process URLs: Add Base URL if needed
    return rawUrls
        .map((url) {
          if (url.isEmpty) return "";
          if (url.startsWith('http')) return url;

          // Handle slash logic cleanly
          return "$baseUrl${url.startsWith('/') ? '' : '/'}$url";
        })
        .where((u) => u.isNotEmpty)
        .toList();
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
