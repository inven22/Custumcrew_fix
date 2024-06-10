import 'package:flutter/material.dart';
import 'package:asistant_rumah/home/widgets/text_widget.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String _selectedSortOption = 'Waktu'; // Opsi default

  List<Map<String, String>> notifications = List.generate(
    5,
    (index) => {
      'title': 'Notifikasi $index',
      'detail': 'Detail notifikasi $index',
    },
  );

  void _sortNotifications() {
    setState(() {
      if (_selectedSortOption == 'Waktu') {
        // Sort by time, assuming the list is already in time order
        notifications = notifications.reversed.toList();
      } else if (_selectedSortOption == 'A-Z') {
        // Sort by title A-Z
        notifications.sort((a, b) => a['title']!.compareTo(b['title']!));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifikasi'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButton<String>(
              value: _selectedSortOption,
              items: [
                DropdownMenuItem(
                  child: Text('Waktu'),
                  value: 'Waktu',
                ),
                DropdownMenuItem(
                  child: Text('A-Z'),
                  value: 'A-Z',
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedSortOption = value!;
                  _sortNotifications();
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.notifications,
                      color: Colors.blue,
                      size: 30.0,
                    ),
                    title: TextWidget(
                      notifications[index]['title']!,
                      18,
                      Colors.black,
                      FontWeight.bold,
                    ),
                    subtitle: TextWidget(
                      notifications[index]['detail']!,
                      14,
                      Colors.grey,
                      FontWeight.normal,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    onTap: () {
                      // Aksi saat notifikasi ditekan (jika diperlukan)
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
