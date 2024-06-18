import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  static const String baseUrl = 'http://127.0.0.1:8000/api';
  List<int> ratings = [];
  List<String> comments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRatings();
  }

  Future<void> fetchRatings() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/ratings'));
      if (response.statusCode == 200) {
        List<dynamic> fetchedRatings = json.decode(response.body);
        setState(() {
          ratings = List<int>.from(fetchedRatings.map((r) => r['rating']));
          comments = List<String>.from(fetchedRatings.map((r) => r['comment']));
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load ratings');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> submitRating(int orderId, int rating, String comment) async {
    try {
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
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rating Page'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: ratings.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            // Replace with your images logic
                            'https://via.placeholder.com/150'),
                        radius: 32,
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name ${index + 1}', // Replace with your names logic
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'Speciality ${index + 1}', // Replace with your speciality logic
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: List.generate(
                                5,
                                (i) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      ratings[index] = i + 1;
                                    });
                                    submitRating(
                                        index, ratings[index], comments[index]);
                                  },
                                  child: Icon(
                                    Icons.star,
                                    color: i < ratings[index]
                                        ? Colors.yellow
                                        : Colors.grey,
                                    size: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
