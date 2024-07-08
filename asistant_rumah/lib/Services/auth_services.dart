import 'dart:convert';
import 'package:asistant_rumah/services/profile_services.dart';
import 'package:http/http.dart' as http;
import 'package:asistant_rumah/services/globals.dart';
import 'package:asistant_rumah/services/token_services.dart';

class AuthServices {
  static Future<http.Response> register(
      String name, String email, String password) async {
    Map data = {
      "name": name,
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse('${baseURL}auth/register');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    return response;
  }

  static Future<http.Response> login(String email, String password) async {
    Map data = {
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    // ignore: prefer_interpolation_to_compose_strings
    var url = Uri.parse(baseURL + 'auth/login');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      Map responseMap = jsonDecode(response.body);
      await TokenServices.setToken(responseMap['token']);
      int userId = responseMap['user']['id'];
      ProfileServices.setUserId(userId);
    }
    return response;
  }
}
