import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  Future<List<dynamic>> getRatings() async {
    final response = await http.get(Uri.parse('$baseUrl/ratings'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load ratings');
    }
  }

  Future<void> submitRating(int orderId, int rating, String comment) async {
    final response = await http.post(
      Uri.parse('$baseUrl/ratings'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'order_id': orderId,
        'rating': rating,
        'comment': comment,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to submit rating');
    }
  }
}
