// import 'package:dio/dio.dart';
// import '../models/dropdown_model.dart';
//
// class PropertyOptionsService {
//   // غير الرابط حسب المحاكي (10.0.2.2) أو الـ IP الحقيقي
//   static const String baseUrl = 'http://10.0.2.2:8000/api/properties';
//   final Dio _dio = Dio();
//
//   // دالة عامة لطلب القوائم لتقليل تكرار الكود
//   Future<List<DropDownModel>> _fetchList(String endpoint, String token) async {
//     try {
//       final response = await _dio.get(
//         '$baseUrl/$endpoint',
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Accept': 'application/json',
//           },
//         ),
//       );
//
//       if (response.statusCode == 200) {
//         final List data = response.data['data'];
//         return data.map((e) => DropDownModel.fromJson(e)).toList();
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } catch (e) {
//       print('Error fetching $endpoint: $e');
//       return []; // إرجاع قائمة فارغة عند الخطأ لمنع توقف التطبيق
//     }
//   }
//
//   // 1. Get Categories
//   Future<List<DropDownModel>> getCategories(String token) async {
//     return _fetchList('allCategories', token);
//   }
//
//   // 2. Get Amenities
//   Future<List<DropDownModel>> getAmenities(String token) async {
//     return _fetchList('allAmenities', token);
//   }
//
//   // 3. Get Governorates
//   Future<List<DropDownModel>> getGovernorates(String token) async {
//     return _fetchList('allGovernorates', token);
//   }
//
//   // 4. Get Cities (تعتمد على ID المحافظة)
//   Future<List<DropDownModel>> getCities(int governorateId, String token) async {
//     // الراوت: /allCities/1
//     return _fetchList('allCities/$governorateId', token);
//   }
// }