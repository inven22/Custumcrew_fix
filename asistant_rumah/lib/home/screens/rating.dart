import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RiwayatPesananPage extends StatefulWidget {
  @override
  _RiwayatPesananPageState createState() => _RiwayatPesananPageState();
}

class _RiwayatPesananPageState extends State<RiwayatPesananPage> with SingleTickerProviderStateMixin {
  List orders = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/getRiwayat'));
    if (response.statusCode == 200) {
      setState(() {
        orders = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load orders');
    }
  }

  void _showRatingDialog(int orderId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double rating = 0.0;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text("Beri Penilaian"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Silakan berikan penilaian Anda:"),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                        ),
                        onPressed: () {
                          setState(() {
                            rating = index + 1.0;
                          });
                        },
                      );
                    }),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text("Batal"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    // Save rating to API
                    saveRating(orderId,rating);
                    Navigator.of(context).pop();
                  },
                  child: Text("Simpan"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> saveRating(int orderId, double rating) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/ratings');
    final response = await http.post(
      url,
      body: jsonEncode({
        'order_id': orderId,
        'rating': rating,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Rating successfully saved: $rating for order $orderId');
    } else {
      print('Failed to save rating. Error: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Pesanan'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Upcoming'),
            Tab(text: 'History'),
           
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          orders.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_note,
                          size: 100,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'No Upcoming Order',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Currently you don’t have any upcoming order.\nPlace and track your orders from here.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to services page
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            onPrimary: Colors.white,
                          ),
                          child: Text('View all services'),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
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
                                  child: Text(
                                    order['household_assistant_id'].toString(),
                                  ),
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
                                      SizedBox(height: 4),
                                      Text(
                                        'Service Date: ${order['service_date']}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _showRatingDialog(
                                              order['order_id'],
                                             
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Theme.of(context).primaryColor,
                                            onPrimary: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          ),
                                          child: Text(
                                            'Beri Penilaian',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
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
          Center(child: Text("History Orders")),  // Placeholder for History tab
          
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RiwayatPesananPage(),
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
  ));
}
