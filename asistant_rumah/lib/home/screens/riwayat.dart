import 'package:flutter/material.dart';
import 'package:asistant_rumah/home/res/lists.dart'; // Import file lists.dart
import 'package:asistant_rumah/home/screens/rating.dart';

class RiwayatPesananPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Pesanan'),
      ),
      body: ListView.builder(
        itemCount: 2, // Hanya menampilkan 2 item
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              elevation: 2, // Memberikan efek bayangan pada kartu
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Memberikan sudut bulat pada kartu
              ),
              child: InkWell(
                onTap: () {
                 
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: images[index], // Menggunakan gambar pesanan dari lists.dart
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              names[index], // Menampilkan nama pesanan dari lists.dart
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              spacilality[index], // Menampilkan spesialisasi dari lists.dart
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               
                                Text(
                                  'Dipesan', // Contoh status pesanan
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RatingPage()),
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


