import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:asistant_rumah/home/screens/profile/profile.dart';
import 'package:asistant_rumah/home/screens/dashboard/home.dart';
import 'package:asistant_rumah/home/widgets/text_widget.dart';

class MoreArt extends StatefulWidget {
  const MoreArt({super.key});

  @override
  State<MoreArt> createState() => _MoreArtState();
}

class _MoreArtState extends State<MoreArt> {
  var opacity = 0.0;
  bool position = false;
  List assistants = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();
      fetchAssistants();
    });
  }

  Future<void> fetchAssistants() async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/api/household-assistants'));

    if (response.statusCode == 200) {
      setState(() {
        assistants = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load assistants');
    }
  }

  void animator() {
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
        padding: const EdgeInsets.only(top: 40),
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 40),
              top: position ? 1 : 50,
              left: 1,
              right: 1,
              child: upperRow(),
            ),
            AnimatedPositioned(
              top: position ? 130 : 160,
              right: 1,
              left: 1,
              duration: const Duration(milliseconds: 60),
              child: AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(milliseconds: 60),
                child: SizedBox(
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        "List Assistant",
                        22,
                        Colors.black,
                        FontWeight.bold,
                        letterSpace: 0,
                      ),
                      TextWidget(
                        "Lihat semua",
                        14,
                        Colors.blue.shade900,
                        FontWeight.bold,
                        letterSpace: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              top: position ? 180 : 280,
              left: 1,
              right: 1,
              duration: const Duration(milliseconds: 40),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 40),
                opacity: opacity,
                child: SizedBox(
                  height: 350,
                  child: ListView.builder(
                    itemCount: assistants.length,
                    itemBuilder: (context, index) {
                      final assistant = assistants[index];
                      return InkWell(
                        onTap: () async {
                          animator();
                          await Future.delayed(
                              const Duration(milliseconds: 500));
                          // ignore: use_build_context_synchronously
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Profile(
                                image:
                                    const AssetImage('assets/images/art2.png'),
                                name: assistant['name'],
                                speciality: assistant['speciality'],
                                order: assistant['order'],
                                email: assistant['email'],
                                biography: assistant['biography'],
                                id: assistant['id'],
                              ),
                              settings:
                                  RouteSettings(arguments: assistant['id']),
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
                                const CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage(
                                      'assets/images/art2.png'), // Use a default image
                                  backgroundColor: Colors.blue,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextWidget(
                                      assistant['name'],
                                      20,
                                      Colors.black,
                                      FontWeight.bold,
                                      letterSpace: 0,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextWidget(
                                      assistant[
                                          'speciality'], // Adjust as needed
                                      17,
                                      Colors.black,
                                      FontWeight.bold,
                                      letterSpace: 0,
                                    ),
                                    const Center(
                                      child: Text(
                                        'Harga : 20.000/ Hari',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                const SizedBox(width: 20),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
      duration: const Duration(milliseconds: 40),
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
          TextWidget("More List", 25, Colors.black, FontWeight.bold),
          const Icon(
            Icons.list,
            color: Colors.black,
            size: 25,
          ),
        ],
      ),
    );
  }
}
