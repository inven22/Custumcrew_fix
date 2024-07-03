import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Home.dart'; // Ensure Home.dart is in the correct directory

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Service App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: babystrrers(), // Set the initial page
    );
  }
}

class babystrrers extends StatefulWidget {
  @override
  _babystrrersState createState() => _babystrrersState();
}

class _babystrrersState extends State<babystrrers> {
  List assistants = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAssistants();
  }

  fetchAssistants() async {
    final response = await http.get(Uri.parse(
        'http://127.0.0.1:8000/api/household-assistants-category?speciality=Childcare'));
    if (response.statusCode == 200) {
      print(response.body); // Log the response
      setState(() {
        assistants = json.decode(response.body);
        isLoading = false;
      });
    } else {
      print('Failed to load household assistants'); // Log the error
      throw Exception('Failed to load household assistants');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baby Sitters'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Home()), // Replace page with Home
            );
          },
          child: Row(
            children: [
              Icon(Icons.arrow_back),
              SizedBox(width: 5),
              Text(
                'Home',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.grid_view),
            onPressed: () {
              // Action to change view to grid view
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Search bar
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Category',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                  // List of childcare services
                  Expanded(
                    child: ListView.builder(
                      itemCount: assistants.length,
                      itemBuilder: (context, index) {
                        final assistant = assistants[index];
                        return ServiceCard(
                          imageUrl: 'assets/images/art2.png',
                          nama: assistant['name'],
                          harga: 'Rp. 20.000/Per jam',
                          title: assistant['speciality'],
                          rating: 4.8,
                          reviews: 37,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String imageUrl;
  final String nama;
  final String harga;
  final String title;
  final double rating;
  final int reviews;

  ServiceCard({
    required this.imageUrl,
    required this.nama,
    required this.harga,
    required this.title,
    required this.rating,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    harga,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text('$rating ($reviews)'),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Starts From',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.more_vert),
          ],
        ),
      ),
    );
  }
}
