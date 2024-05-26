import 'package:asistant_rumah/home/res/lists.dart';
import 'package:flutter/material.dart';

class RatingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rating Page'),
      ),
      body: ListView.builder(
        itemCount: names.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: images[index],
                  radius: 32,
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        names[index],
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        spacilality[index],
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: List.generate(
                          5,
                          (i) => Icon(
                            Icons.star,
                            color: i < 3 ? Colors.yellow : Colors.grey,
                            size: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


