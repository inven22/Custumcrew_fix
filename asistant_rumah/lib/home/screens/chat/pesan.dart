import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:asistant_rumah/home/screens/dashboard/home.dart';
import 'Chat.dart';

class Pesan extends StatefulWidget {
  @override
  State<Pesan> createState() => _SeeAllState();
}

class _SeeAllState extends State<Pesan> {
  var opacity = 0.0;
  bool position = false;
  List<dynamic> messages = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();
    });
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/getRiwayat'));
    if (response.statusCode == 200) {
      setState(() {
        messages = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load messages');
    }
  }

  animator() {
    if (opacity == 1) {
      opacity = 0;
      position = false;
    } else {
      opacity = 1;
      position = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 20),
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 400),
              top: position ? 20 : 50, // Nilai top diubah untuk menyesuaikan posisi awal
              left: 40,
              right: 20,
              child: upperRow(),
            ),
            AnimatedPositioned(
              top: position ? 80 : 140, // Nilai top diubah untuk menyesuaikan posisi awal
              right: 40,
              left: 40,
              duration: Duration(milliseconds: 400),
              child: AnimatedOpacity(
                opacity: opacity,
                duration: Duration(milliseconds: 400),
                child: Container(
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "List Chat",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Lihat semua",
                        style: TextStyle(fontSize: 14, color: Colors.blue.shade900, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              top: position ? 110 : 170, // Nilai top diubah untuk menyesuaikan posisi awal
              left: 20,
              right: 20,
              duration: Duration(milliseconds: 500),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: opacity,
                child: Container(
                  height: 630,
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () async {
                        animator();
                        await Future.delayed(const Duration(milliseconds: 500));
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Chat(
                              image: AssetImage('assets/default_avatar.png'), // Ganti dengan gambar default jika diperlukan
                              name: messages[index]['household_assistant_id'].toString(),
                              specialist: messages[index]['service_date'],
                            ),
                          ),
                        );
                        animator();
                      },
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SizedBox(
                          height: 120,
                          width: double.infinity,
                          child: Row(
                            children: [
                              const SizedBox(width: 20),
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage('assets/default_avatar.png'), // Ganti dengan gambar default jika diperlukan
                                backgroundColor: Colors.blue,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'ID Transaksi ${messages[index]['household_assistant_id']}',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Tanggal pesan : ${messages[index]['service_date']}',
                                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.orangeAccent,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.orangeAccent,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.orangeAccent,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.orangeAccent,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.orangeAccent,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.navigation_sharp,
                                color: Colors.blue,
                              ),
                              const SizedBox(width: 40),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget upperRow() {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              animator();
              Timer(const Duration(milliseconds: 600), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ),
                );
              });
            },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
              size: 25,
            ),
          ),
          Text("Message", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          const Icon(
            Icons.message,
            color: Colors.black,
            size: 25,
          ),
        ],
      ),
    );
  }
}
