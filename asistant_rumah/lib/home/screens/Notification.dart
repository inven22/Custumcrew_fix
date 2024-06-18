import 'package:flutter/material.dart';
import 'package:asistant_rumah/home/widgets/text_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:asistant_rumah/home/screens/NotificationModel.dart'; // Import the model
import 'package:asistant_rumah/home/widgets/text_widget.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late Future<List<NotificationModel>> notifications;

  @override
  void initState() {
    super.initState();
    notifications = fetchNotifications();
  }

  Future<List<NotificationModel>> fetchNotifications() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/getNotifications'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => NotificationModel.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifikasi'),
      ),
      body: FutureBuilder<List<NotificationModel>>(
        future: notifications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No notifications found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    Icons.notifications,
                    color: Colors.blue,
                  ),
                  title: TextWidget(
                    'Order ID: ${snapshot.data![index].orderId}',
                    18,
                    Colors.black,
                    FontWeight.normal,
                  ),
                  subtitle: TextWidget(
                    snapshot.data![index].isi,
                    14,
                    Colors.grey,
                    FontWeight.normal,
                  ),
                  onTap: () {
                    // Action when notification is tapped (if needed)
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
