import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:asistant_rumah/services/globals.dart';
import 'package:asistant_rumah/services/token_services.dart';

class ProfileServices {
  static Future<http.Response> getProfile() async {
    String? token = await TokenServices.getToken();

    http.Response response = await http.get(
      // ignore: prefer_interpolation_to_compose_strings
      Uri.parse(baseURL + 'profile'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  static Future<Map<String, dynamic>> fetchProfileData() async {
    try {
      http.Response response = await getProfile();
      if (response.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(response.body);
        return responseMap;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized');
      } else if (response.statusCode == 403) {
        throw Exception('Forbidden');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found');
      } else if (response.statusCode == 500) {
        throw Exception('Internal Server Error');
      } else {
        throw Exception('Failed to fetch profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching profile: $e');
    }
  }
}
