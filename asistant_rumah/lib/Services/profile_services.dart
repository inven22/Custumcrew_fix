import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:asistant_rumah/services/globals.dart';
import 'package:asistant_rumah/services/token_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileServices {
  static int? _userId;

  static void setUserId(int userId) {
    if (userId <= 0) {
      throw Exception('Invalid userId: $userId');
    }
    _userId = userId;
  }

  static int? getUserId() {
    return _userId;
  }

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

  static Future<Map<String, dynamic>?> updateProfile({
    required String name,
    required String email,
    required String password,
    required String alamat,
    required String phone,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var url = Uri.parse('http://127.0.0.1:8000/api/auth/update-profile');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
      'alamat': alamat,
      'phone': phone,
    });

    var response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }
}
