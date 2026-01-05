
import 'package:dio/dio.dart';
import '../models/property_model.dart';

class ApiService {
  // ⚠️ ملاحظة هامة:
  // إذا كنت تستخدم المحاكي (Emulator) اترك الرابط كما هو: 10.0.2.2
  // إذا كنت تستخدم موبايل حقيقي، استبدل الرقم بـ IPv4 الخاص بلابتوبك (مثل 192.168.1.5)
  static const String baseUrl = 'http://192.168.1.4:8000/api';

  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10), // 10 ثواني بدلاً من 0
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  /// دالة إضافة عقار جديد (مع صور)
  Future<void> addProperty(PropertyModel property, String token) async {
    try {
      String apiUrl = '$baseUrl/properties'; // حسب الراوت اللي بملف البوست مان تبعك

      // نستخدم FormData لأننا نرفع صور وملفات
      FormData formData = FormData.fromMap({
        'price': property.price,
        'area': property.area,
        'bedrooms': property.beds,      // انتبه لتسمية الباك إند
        'bathrooms': property.baths,    // انتبه لتسمية الباك إند
        'address': property.address,
        'category': property.category,
        'governorate': property.governorate,
        'city': property.city,
        // الـ owner لا نرسله لأن الباك إند يأخذه من التوكن
      });

      // 1. إضافة الميزات (Amenities) كمصفوفة
      // في لارافيل نرسلها بالشكل: amenities[]
      for (var item in property.amenities) {
        formData.fields.add(MapEntry('amenities[]', item));
      }

      // 2. إضافة الصور
      if (property.localImages != null) {
        for (var file in property.localImages!) {
          // استخراج اسم الملف
          String fileName = file.path.split('/').last;

          formData.files.add(MapEntry(
            'images[]', // اسم الحقل في الباك إند (تأكد من البوست مان)
            await MultipartFile.fromFile(file.path, filename: fileName),
          ));
        }
      }

      // 3. إرسال الطلب
      final response = await _dio.post(
        apiUrl,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // التوكن
            'Accept': 'application/json',     // ضروري جداً مع لارافيل
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Property Added Successfully: ${response.data}");
      } else {
        throw Exception('Failed to add property: ${response.statusMessage}');
      }

    } catch (e) {
      // طباعة الخطأ لمعرفته (مفيد جداً وقت التجريب)
      if (e is DioException) {
        print("Dio Error: ${e.response?.data}"); // يعطيك رسالة الخطأ من لارافيل
      }
      print("Error sending property: $e");
      throw e; // نرمي الخطأ ليمسكه الكيوبت ويعرض SnackBar
    }
  }
}