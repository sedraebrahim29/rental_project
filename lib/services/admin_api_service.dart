import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pending_user.dart';

class AdminApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api/admin';

  /// جلب عدد الطلبات
  static Future<int> getPendingCount() async {
    final res = await http.get(Uri.parse('$baseUrl/pendingRegistrationCount'));
    final data = json.decode(res.body);
    return data['data'];
  }

  /// جلب كل الطلبات
  static Future<List<dynamic>> getPendingList() async {
    final res = await http.get(Uri.parse('$baseUrl/pendingRegistration'));
    final data = json.decode(res.body);
    return data['data'];
  }

  /// تفاصيل مستخدم
  static Future<PendingUser> getPendingDetails(int id) async {
    final res = await http.get(Uri.parse('$baseUrl/pendingRegistration/$id'));
    final data = json.decode(res.body);
    return PendingUser.fromJson(data['data']);
  }

  /// قبول
  static Future<void> approve(int id) async {
    await http.patch(Uri.parse('$baseUrl/approve/$id'));
  }

  /// رفض
  static Future<void> reject(int id) async {
    await http.patch(Uri.parse('$baseUrl/reject/$id'));
  }
}
