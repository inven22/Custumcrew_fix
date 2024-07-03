import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RiwayatPesananPage extends StatefulWidget {
  @override
  _RiwayatPesananPageState createState() => _RiwayatPesananPageState();
}

class _RiwayatPesananPageState extends State<RiwayatPesananPage> with SingleTickerProviderStateMixin {
  List upcomingOrders = [];
  List historyOrders = [];
  late TabController _tabController;
  int ratingCount = 0; // Counter for rating submissions
  Map<int, double> ratedOrders = {}; // Map to store ratings for each order ID

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadOrders();
  }

  Future<void> fetchOrders() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/getRiwayat'));
    if (response.statusCode == 200) {
      setState(() {
        upcomingOrders = json.decode(response.body);
      });
      saveOrders();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<void> saveOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('upcomingOrders', json.encode(upcomingOrders));
    await prefs.setString('historyOrders', json.encode(historyOrders));
  }

  Future<void> loadOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      upcomingOrders = json.decode(prefs.getString('upcomingOrders') ?? '[]');
      historyOrders = json.decode(prefs.getString('historyOrders') ?? '[]');
    });

    if (upcomingOrders.isEmpty) {
      fetchOrders();
    }
  }

  void _showRatingDialog(int orderId) {
    double initialRating = ratedOrders.containsKey(orderId) ? ratedOrders[orderId]! : 0.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        double rating = initialRating;
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
                    setState(() {
                      ratedOrders[orderId] = rating; // Save rating for this order
                      ratingCount++; // Increment count on each rating
                    });
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

  void _moveOrderToHistory(int orderId) {
    setState(() {
      // Find the order in upcomingOrders
      final order = upcomingOrders.firstWhere((order) => order['household_assistant_id'] == orderId);
      // Remove the order from upcomingOrders
      upcomingOrders.remove(order);
      // Add the order to historyOrders
      historyOrders.add(order);
      // Save the orders
      saveOrders();
      // Switch to the History tab
      _tabController.index = 1;
    });
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
          upcomingOrders.isEmpty
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
                  itemCount: upcomingOrders.length,
                  itemBuilder: (context, index) {
                    final order = upcomingOrders[index];
                    final orderId = order['household_assistant_id'];

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
                                    orderId.toString(),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ID: $orderId',
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
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                _showRatingDialog(orderId);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Theme.of(context).primaryColor,
                                                onPrimary: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                              ),
                                              child: Text(
                                                ratedOrders.containsKey(orderId) ? 'Edit Rating' : 'Beri Penilaian',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            ElevatedButton(
                                              onPressed: () {
                                                _moveOrderToHistory(orderId);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.grey,
                                                onPrimary: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                              ),
                                              child: Text(
                                                'Tandai selesai',
                                                style: TextStyle(
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
          historyOrders.isEmpty
              ? Center(child: Text("No History Orders"))
              : ListView.builder(
                  itemCount: historyOrders.length,
                  itemBuilder: (context, index) {
                    final order = historyOrders[index];
                    final orderId = order['household_assistant_id'];

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
                                    orderId.toString(),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ID: $orderId',
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
        ],
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: RiwayatPesananPage(),
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
  ));
}
