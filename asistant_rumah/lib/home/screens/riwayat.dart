import 'package:flutter/material.dart';
import 'package:asistant_rumah/home/res/lists.dart'; // Import file lists.dart
import 'package:asistant_rumah/home/screens/rating.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RiwayatPesananPage extends StatefulWidget {
  @override
  _RiwayatPesananPageState createState() => _RiwayatPesananPageState();
}

class _RiwayatPesananPageState extends State<RiwayatPesananPage> {
  List orders = [];

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/getRiwayat'));
    if (response.statusCode == 200) {
      setState(() {
        orders = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Pesanan'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        child: Text(order['household_assistant_id']
                            .toString()), // Menampilkan household_assistant_id sebagai contoh
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ID: ${order['household_assistant_id']}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Service Date: ${order['service_date']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 8),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RatingPage()),
                                );
                              },
                              child: Text(
                                'Beri Penilaian',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
