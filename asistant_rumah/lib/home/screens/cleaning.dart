import 'package:flutter/material.dart';
import 'Home.dart'; // Pastikan file Home.dart ada di direktori yang benar
import 'package:asistant_rumah/home/res/lists.dart';

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
      home: ServiceHomePage(), // Mengatur halaman awal
    );
  }
}

class ServiceHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cleaning'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home()), // Mengganti halaman dengan Home
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
            // Daftar layanan perbaikan AC
            Expanded(
              child: ListView(
                children: [
                  ServiceCard(
                   imageUrl: ('assets/images/art2.png'),
                    nama: 'John Doe',
                    title: 'Cleaning',
                    rating: 4.8,
                    reviews: 37,
                  ),
                  
                  // Tambahkan ServiceCard lainnya di sini
                ],
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
  final String title;
  final double rating;
  final int reviews;

  ServiceCard({
    required this.imageUrl,
    required this.nama,
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
