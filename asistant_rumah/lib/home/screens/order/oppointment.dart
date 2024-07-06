// ignore_for_file: file_names
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:asistant_rumah/services/profile_services.dart';

class Oppointment extends StatefulWidget {
  final int id;

  const Oppointment({Key? key, required this.id}) : super(key: key);

  @override
  State<Oppointment> createState() => _OppointmentState();
}

class _OppointmentState extends State<Oppointment> {
  TextEditingController serviceDateController = TextEditingController();
  // ignore: non_constant_identifier_names
  int user_id = 0;
  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> createOrder() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/orders'),
      body: jsonEncode({
        'user_id': user_id,
        'household_assistant_id': widget.id,
        'service_date': serviceDateController.text,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order berhasil dibuat ${response.statusCode}'),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal membuat order ${response.statusCode}'),
        ),
      );
    }
  }

  fetchProfile() async {
    try {
      Map<String, dynamic> profileData =
          await ProfileServices.fetchProfileData();
      setState(() {
        user_id = profileData['user']['id'];
      });
    } catch (e) {
      setState(() {
        user_id = 0;
      });
      // ignore: avoid_print
      print('Error fetching profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Pesanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'ID: ${widget.id} user_id: $user_id',
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: serviceDateController,
              decoration: const InputDecoration(labelText: 'Tanggal Layanan'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: createOrder,
              child: const Text('Buat Pesanan'),
            ),
          ],
        ),
      ),
    );
  }
}
