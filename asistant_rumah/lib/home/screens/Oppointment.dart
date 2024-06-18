import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Oppointment extends StatefulWidget {
  final int id;

  Oppointment({Key? key, required this.id}) : super(key: key);

  @override
  State<Oppointment> createState() => _OppointmentState();
}

class _OppointmentState extends State<Oppointment> {
  TextEditingController serviceDateController = TextEditingController();

  Future<void> createOrder() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/orders'),
      body: jsonEncode({
        'household_assistant_id': widget.id,
        'service_date': serviceDateController.text,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // Jika request berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order berhasil dibuat'),
        ),
      );
    } else {
      // Jika request gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal membuat order'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat Pesanan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'ID: ${widget.id}',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: serviceDateController,
              decoration: InputDecoration(labelText: 'Tanggal Layanan'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: createOrder,
              child: Text('Buat Pesanan'),
            ),
          ],
        ),
      ),
    );
  }
}
