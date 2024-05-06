import 'package:flutter/material.dart';
import 'package:asistant_rumah/home/widgets/text_widget.dart';

class RiwayatPesananPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Pesanan'),
      ),
      body: ListView.builder(
        itemCount: 5, // Jumlah riwayat pesanan dummy
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(
              Icons.shopping_cart, // Icon riwayat pesanan
              color: Colors.blue, // Warna icon
            ),
            title: TextWidget(
              'Pesanan $index', // Judul riwayat pesanan
              18, // Ukuran teks
              Colors.black, // Warna teks
              FontWeight.normal, // Bobot teks
            ),
            subtitle: TextWidget(
              'Detail pesanan $index', // Detail riwayat pesanan
              14, // Ukuran teks
              Colors.grey, // Warna teks
              FontWeight.normal, // Bobot teks
            ),
            onTap: () {
              // Aksi saat riwayat pesanan ditekan (jika diperlukan)
            },
          );
        },
      ),
    );
  }
}
