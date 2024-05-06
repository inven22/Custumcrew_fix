import 'package:flutter/material.dart';
import 'package:asistant_rumah/home/widgets/text_widget.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifikasi'),
      ),
      body: ListView.builder(
        itemCount: 5, // Jumlah notifikasi dummy
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(
              Icons.notifications, // Icon notifikasi
              color: Colors.blue, // Warna icon
            ),
            title: TextWidget(
              'Notifikasi $index', // Judul notifikasi
              18, // Ukuran teks
              Colors.black, // Warna teks
              FontWeight.normal, // Bobot teks
            ),
            subtitle: TextWidget(
              'Detail notifikasi $index', // Detail notifikasi
              14, // Ukuran teks
              Colors.grey, // Warna teks
              FontWeight.normal, // Bobot teks
            ),
            onTap: () {
              // Aksi saat notifikasi ditekan (jika diperlukan)
            },
          );
        },
      ),
    );
  }
}
