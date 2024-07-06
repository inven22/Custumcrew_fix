import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: const RiwayatPesananPage(),
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
  ));
}

class RiwayatPesananPage extends StatefulWidget {
  const RiwayatPesananPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RiwayatPesananPageState createState() => _RiwayatPesananPageState();
}

class _RiwayatPesananPageState extends State<RiwayatPesananPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List upcomingOrders = [];
  List historyOrders = [];
  int ratingCount = 0;
  Map<int, double> ratedOrders = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchOrders();
    loadHistoryOrders();
  }

  Future<void> fetchOrders() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/getRiwayat'));
    if (response.statusCode == 200) {
      setState(() {
        upcomingOrders = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<void> loadHistoryOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String historyOrdersJson = prefs.getString('historyOrders') ?? '[]';
    setState(() {
      historyOrders = json.decode(historyOrdersJson);
    });
  }

  Future<void> saveHistoryOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('historyOrders', json.encode(historyOrders));
  }

  void _moveOrderToHistory(int orderId) {
    setState(() {
      // Find the order in upcomingOrders
      final order = upcomingOrders
          .firstWhere((order) => order['household_assistant_id'] == orderId);
      // Remove the order from upcomingOrders
      upcomingOrders.remove(order);
      // Add the order to historyOrders
      historyOrders.add(order);
      // Switch to the History tab
      _tabController.index = 1;
    });
  }

  void _showRatingDialog(int orderId) {
    double initialRating =
        ratedOrders.containsKey(orderId) ? ratedOrders[orderId]! : 0.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        double rating = initialRating;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text("Beri Penilaian"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Silakan berikan penilaian Anda:"),
                  const SizedBox(height: 20),
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
                  child: const Text("Batal"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // ignore: deprecated_member_use
                    primary: Theme.of(context).primaryColor,
                    // ignore: deprecated_member_use
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    // ignore: avoid_print
                    print('Rating diberikan: $rating');
                    setState(() {
                      ratedOrders[orderId] =
                          rating; // Save rating for this order
                      ratingCount++; // Increment count on each rating
                    });
                    _moveOrderToHistory(orderId);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Simpan"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pesanan'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab Upcoming
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
                        const SizedBox(height: 20),
                        const Text(
                          'No Upcoming Order',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Currently you don’t have any upcoming order.\nPlace and track your orders from here.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to services page
                          },
                          style: ElevatedButton.styleFrom(
                            // ignore: deprecated_member_use
                            primary: Theme.of(context).primaryColor,
                            // ignore: deprecated_member_use
                            onPrimary: Colors.white,
                          ),
                          child: const Text('View all services'),
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
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ID: $orderId',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Service Date: ${order['service_date']}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
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
                                                // ignore: deprecated_member_use
                                                primary: Theme.of(context)
                                                    .primaryColor,
                                                // ignore: deprecated_member_use
                                                onPrimary: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                              child: Text(
                                                ratedOrders.containsKey(orderId)
                                                    ? 'Edit Rating'
                                                    : 'Beri Penilaian',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            ElevatedButton(
                                              onPressed: () {
                                                _moveOrderToHistory(orderId);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                // ignore: deprecated_member_use
                                                primary: Colors.grey,
                                                // ignore: deprecated_member_use
                                                onPrimary: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                              child: const Text(
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

          // Tab History
          historyOrders.isEmpty
              ? const Center(child: Text("No History Orders"))
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
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ID: $orderId',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Service Date: ${order['service_date']}',
                                        style: const TextStyle(
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
