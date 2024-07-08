import 'package:asistant_rumah/services/token_services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterHouseholdServices {
  // static const String _baseUrl = 'http://127.0.0.1:8000/api';

  static Future<Map<String, dynamic>> registerHouseholdAssistant(
      String speciality) async {
    String? token = await TokenServices.getToken();
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/register-household-assistant'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'speciality': speciality,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register as household assistant');
    }
  }
}
