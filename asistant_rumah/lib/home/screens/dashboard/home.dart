import 'dart:async';
import 'dart:convert';
import 'package:asistant_rumah/home/screens/list_household/baby_category.dart';
import 'package:asistant_rumah/home/screens/profile/profile.dart';
import 'package:asistant_rumah/home/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:asistant_rumah/home/screens/chat/pesan.dart';
import 'package:asistant_rumah/services/profile_services.dart';
import 'package:asistant_rumah/home/screens/order/riwayat.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:asistant_rumah/home/screens/list_household/office_category.dart';
import 'package:asistant_rumah/home/screens/profile/account_screen.dart';
import 'package:asistant_rumah/home/screens/list_household/more_art.dart';
import 'package:asistant_rumah/home/screens/list_household/cleaning_category.dart';
import 'package:asistant_rumah/home/model/household_assistant.dart';
import 'package:asistant_rumah/home/screens/notifications/notifications.dart';
import 'package:asistant_rumah/home/screens/list_household/all_categori.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var opacity = 0.0;
  bool position = false;
  String _userName = 'Loading...';
  List assistants = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();
      fetchProfile();
      fetchAssistants();
    });
  }

  void animator() {
    setState(() {
      opacity = opacity == 1 ? 0 : 1;
      position = !position;
    });
  }

  fetchProfile() async {
    try {
      Map<String, dynamic> profileData =
          await ProfileServices.fetchProfileData();
      setState(() {
        _userName = profileData['user']['name'];
      });
    } catch (e) {
      setState(() {
        _userName = 'Error';
      });
      // ignore: avoid_print
      print('Error fetching profile: $e');
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 30, left: 0, right: 0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                top: position ? 1 : 100,
                right: 20,
                left: 20,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Selamat datang",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black.withOpacity(.7),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _userName,
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.phonelink_ring),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationPage(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              AnimatedPositioned(
                top: position ? 80 : 140,
                left: 20,
                right: 20,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search_sharp,
                          size: 30,
                          color: Colors.black.withOpacity(.5),
                        ),
                        hintText: "   Cari Assistant rumah tangga",
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                top: position ? 150 : 220,
                right: 20,
                left: 20,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: SizedBox(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(
                              ('assets/images/home.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              categoryRow(),
              AnimatedPositioned(
                top: position ? 420 : 500,
                left: 20,
                right: 20,
                duration: const Duration(milliseconds: 40),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 30),
                  opacity: opacity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rekomendasi",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black.withOpacity(.8),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          animator();
                          await Future.delayed(
                              const Duration(milliseconds: 50));
                          // ignore: use_build_context_synchronously
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MoreArt(),
                            ),
                          );
                          animator();
                        },
                        child: Text(
                          "Lihat semua art",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue.shade600.withOpacity(.8),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              artList(),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 40),
                  opacity: opacity,
                  child: CurvedNavigationBar(
                    backgroundColor: Colors.white,
                    items: [
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(Icons.home_filled,
                            color: Colors.blue, size: 30),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RiwayatPesananPage()),
                          );
                        },
                        child: const Icon(Icons.calendar_month_rounded,
                            color: Colors.black, size: 30),
                      ),
                      GestureDetector(
                        onTap: () {
                          Timer(const Duration(milliseconds: 60), () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Pesan(),
                              ),
                            );
                          });
                        },
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 40),
                          opacity: opacity,
                          child: const Icon(Icons.message,
                              color: Colors.black, size: 30),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AccountScreen(),
                            ),
                          );
                        },
                        child: const Icon(Icons.account_circle_outlined,
                            color: Colors.black, size: 30),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget artList() {
    return AnimatedPositioned(
      top: position ? 460 : 550,
      left: 20,
      right: 20,
      duration: const Duration(milliseconds: 40),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 40),
        opacity: opacity,
        child: SizedBox(
          height: 270,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: assistants.length,
            itemBuilder: (context, index) {
              final assistant = assistants[index];
              return InkWell(
                onTap: () async {
                  animator();
                  await Future.delayed(const Duration(milliseconds: 500));
                  // ignore: use_build_context_synchronously
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(
                        image: const AssetImage('assets/images/art2.png'),
                        name: assistant['name'],
                        speciality: assistant['speciality'],
                        order: assistant['order'],
                        email: assistant['email'],
                        biography: assistant['biography'],
                        id: assistant['id'],
                      ),
                      settings: RouteSettings(arguments: assistant['id']),
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
                              assistant['speciality'], // Adjust as needed
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
    );
  }

  Widget artCard(String name, String specialist, String harga, AssetImage image,
      HouseholdAssistant assistant) {
    int ratingCount =
        assistant.order ?? 0; // Default to 0 if assistant.order is null

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profile(
              image: image,
              name: assistant.name,
              speciality: assistant.speciality,
              order: assistant.order,
              email: assistant.email,
              biography: assistant.biography,
              id: assistant.id,
            ),
            settings: RouteSettings(arguments: assistant.id),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          height: 120,
          width: double.infinity,
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              CircleAvatar(
                radius: 30,
                backgroundImage: image,
                backgroundColor: Colors.blue,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    specialist,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    harga,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => Icon(
                        Icons.star,
                        color: index < ratingCount
                            ? Colors.orangeAccent
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.navigation_sharp,
                color: Colors.blue,
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryRow() {
    return AnimatedPositioned(
      top: position ? 320 : 420,
      left: 25,
      right: 25,
      duration: const Duration(milliseconds: 40),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 40),
        opacity: opacity,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              category(
                "assets/images/clean.png",
                "Cleaning",
                10,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const CleaningCategory(), // Ganti dengan halaman yang sesuai
                    ),
                  );
                },
              ),
              category(
                "assets/images/baby.png",
                "Baby.C",
                15,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const BabyCategory(), // Ganti dengan halaman yang sesuai
                    ),
                  );
                },
              ),
              category(
                "assets/images/ofice.png",
                "Office.C",
                10,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const OfficeCategory(), // Ganti dengan halaman yang sesuai
                    ),
                  );
                },
              ),
              category(
                "assets/images/app.png",
                "Lainnya",
                10,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const AllCategory(), // Ganti dengan halaman yang sesuai
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget category(
      String asset, String txt, double padding, VoidCallback onTap) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              padding: EdgeInsets.all(padding),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Image(
                  image: AssetImage(asset),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          txt,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
