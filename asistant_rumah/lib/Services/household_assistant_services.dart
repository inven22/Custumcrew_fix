import 'package:asistant_rumah/services/profile_services.dart';
import 'package:http/http.dart' as http;
import 'package:asistant_rumah/services/globals.dart';
import 'package:asistant_rumah/services/token_services.dart';

class HouseholdAssistantServices {
  static Future<http.Response> getHouseholdAssistantData() async {
    try {
      // Fetch profile data
      Map<String, dynamic> profileData =
          await ProfileServices.fetchProfileData();
      // Extract user ID
      int userId = profileData['user']['id'];
      String? token = await TokenServices.getToken();
      // Call household assistant endpoint using the extracted user ID
      print('User_id: ${userId}');
      print('token: ${token}');
      http.Response response = await http.get(
        Uri.parse(baseURL + 'get-self-household-assistant?user_id=$userId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(
          'cek url: http://127.0.0.1:8000/api/get-self-household-assistant?user_id=${userId}');

      return response;
    } catch (e) {
      throw Exception('Error fetching household assistant data: $e');
    }
  }
}
