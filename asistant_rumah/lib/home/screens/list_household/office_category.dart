import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../dashboard/home.dart'; // Pastikan Home.dart berada di direktori yang benar

class OfficeCategory extends StatelessWidget {
  const OfficeCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Office Cleaning'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const Home()), // Mengganti halaman dengan Home
            );
          },
          child: const Row(
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
            icon: const Icon(Icons.grid_view),
            onPressed: () {
              // Aksi untuk mengubah tampilan menjadi grid view
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Category',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            // Daftar layanan perbaikan AC
            Expanded(
              child: FutureBuilder(
                future: fetchAssistants(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasError) {
                      return const Center(
                          child: Text('Failed to load assistants'));
                    } else {
                      List assistants = snapshot.data ?? [];
                      return ListView.builder(
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
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<dynamic>> fetchAssistants() async {
    final response = await http.get(Uri.parse(
        'http://127.0.0.1:8000/api/household-assistants-category?speciality=OfficeCleaning'));
    if (response.statusCode == 200) {
      // ignore: avoid_print
      print(response.body); // Log response
      return json.decode(response.body);
    } else {
      // ignore: avoid_print
      print('Failed to load assistants'); // Log error
      throw Exception('Failed to load assistants');
    }
  }
}

class ServiceCard extends StatelessWidget {
  final String imageUrl;
  final String nama;
  final String harga;
  final String title;
  final double rating;
  final int reviews;

  const ServiceCard({
    super.key,
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
      margin: const EdgeInsets.symmetric(vertical: 10),
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
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    harga,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text('$rating ($reviews)'),
                    ],
                  ),
                  const SizedBox(height: 5),
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
            const Icon(Icons.more_vert),
          ],
        ),
      ),
    );
  }
}
