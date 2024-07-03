import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:asistant_rumah/Services/auth_services.dart';

class Oppointment extends StatefulWidget {
  final int id;

  Oppointment({Key? key, required this.id}) : super(key: key);

  @override
  State<Oppointment> createState() => _OppointmentState();
}

class _OppointmentState extends State<Oppointment> {
  TextEditingController serviceDateController = TextEditingController();
  int user_id = 0;
  String _token = '';
  @override
  void initState() {
    super.initState();
    fetchProfile();
    loadToken();
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
      // Jika request berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order berhasil dibuat ${response.statusCode}'),
        ),
      );
    } else {
      // Jika request gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal membuat order ${response.statusCode}'),
        ),
      );
    }
  }

  loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token') ?? '';
      print('Token: $_token'); // Print token for debugging
    });
  }

  fetchProfile() async {
    try {
      http.Response response = await AuthServices.getProfile();
      print('Response Status Code: ${response.statusCode}');
      print('Profile Response: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(response.body);
        if (responseMap['user'] != null && responseMap['user']['id'] != null) {
          setState(() {
            user_id = responseMap['user']['id']; // Assuming user_id is a String
          });
        } else {
          setState(() {
            user_id = 0;
          });
        }
      } else {
        setState(() {
          user_id = 0;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        user_id = 0;
      });
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
              'ID: ${widget.id} user_id: ${user_id}',
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
