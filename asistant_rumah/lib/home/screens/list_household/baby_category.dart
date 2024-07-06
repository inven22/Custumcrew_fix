import 'package:asistant_rumah/home/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../dashboard/home.dart'; // Ensure Home.dart is in the correct directory

class BabyCategory extends StatefulWidget {
  const BabyCategory({Key? key}) : super(key: key);

  @override
  _BabyCategoryState createState() => _BabyCategoryState();
}

class _BabyCategoryState extends State<BabyCategory> {
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
        title: const Text('Baby Sitters'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ),
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
              // Action to change view to grid view
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
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
                  // List of childcare services
                  Expanded(
                    child: ListView.builder(
                      itemCount: assistants.length,
                      itemBuilder: (context, index) {
                        final assistant = assistants[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Profile(
                                  image: AssetImage('assets/images/art2.png'),
                                  name: assistant['name'],
                                  speciality: assistant['speciality'],
                                  order: assistant['order'],
                                  email: assistant['email'],
                                  biography: assistant['biography'],
                                  id: assistant['id'],
                                ),
                                settings: RouteSettings(
                                  arguments: assistant['id'],
                                ),
                              ),
                            );
                          },
                          child: ServiceCard(
                            imageUrl: 'assets/images/art2.png',
                            nama: assistant['name'],
                            harga: 'Rp. 20.000/Per jam',
                            title: assistant['speciality'],
                            rating: 4.8,
                            reviews: 37,
                          ),
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

  const ServiceCard({
    Key? key,
    required this.imageUrl,
    required this.nama,
    required this.harga,
    required this.title,
    required this.rating,
    required this.reviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
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
