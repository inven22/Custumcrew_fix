import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:asistant_rumah/services/globals.dart';

class OrderServices {
  static Future<void> createOrder(
      int userId, int assistantId, String serviceDate) async {
    final response = await http.post(
      Uri.parse('$baseURL/orders'),
      body: jsonEncode({
        'user_id': userId,
        'household_assistant_id': assistantId,
        'service_date': serviceDate,
      }),
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal membuat order');
    }
  }
}
