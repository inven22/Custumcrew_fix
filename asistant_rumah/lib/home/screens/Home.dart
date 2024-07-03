import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:asistant_rumah/home/screens/pesan.dart';
import 'package:asistant_rumah/home/res/lists.dart';
import 'package:asistant_rumah/home/widgets/text_widget.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:asistant_rumah/home/screens/account_screen.dart';
import 'Profile.dart';
import 'pesan.dart';
import 'More_art.dart';
import 'Notification.dart';
import 'riwayat.dart';
import 'cleaning.dart';
import 'babyC.dart';
import 'OfficeC.dart';
import 'all_categori.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var opacity = 0.0;
  bool position = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();
    });
  }

  void animator() {
    setState(() {
      opacity = opacity == 1 ? 0 : 1;
      position = !position;
    });
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
                            "Ahmad",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.phonelink_ring),
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
                    child: Container(
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
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: opacity,
                  child: Container(
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
                                const Duration(milliseconds: 500));
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => moreart(),
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
              ),
              artList(),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: CurvedNavigationBar(
                    backgroundColor: Colors.white,
                    items: [
                      GestureDetector(
                        onTap: () {},
                        child: Icon(Icons.home_filled,
                            color: Colors.blue, size: 30),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RiwayatPesananPage()),
                          );
                        },
                        child: Icon(Icons.calendar_month_rounded,
                            color: Colors.black, size: 30),
                      ),
                      GestureDetector(
                        onTap: () {
                          Timer(const Duration(milliseconds: 600), () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => pesan(),
                              ),
                            );
                          });
                        },
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 400),
                          opacity: opacity,
                          child: Icon(Icons.message,
                              color: Colors.black, size: 30),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AccountScreen(),
                            ),
                          );
                        },
                        child: Icon(Icons.account_circle_outlined,
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
      duration: const Duration(milliseconds: 400),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: opacity,
        child: SizedBox(
          height: 270,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // Action when the first doctor card is tapped
                    // You can navigate to a new screen or perform any other action
                  },
                  child: artCard("Sarah", "Baby sitters","Rp 20.000 / Perhari", AssetImage('assets/images/doctor1.jpg')),
                ),
                GestureDetector(
                  onTap: () {
                    // Action when the second doctor card is tapped
                    // You can navigate to a new screen or perform any other action
                  },
                  child: artCard("Jhon dou", "Cleaning","Rp 30.000 / Perhari", AssetImage('assets/images/doctor2.jpg')),
                ),
                GestureDetector(
                  onTap: () {
                    // Action when the third doctor card is tapped
                    // You can navigate to a new screen or perform any other action
                  },
                  child: artCard("Emily", "Office cleaning","Rp 20.000 / Perhari", AssetImage('assets/images/doctor3.jpg')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget artCard(String name, String specialist,String harga, AssetImage image) {
    return Card(
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
              children: [
                Text(
                  name,
                  style: TextStyle(
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
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  harga,
                  style: TextStyle(
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
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.navigation_sharp,
              color: Colors.blue,
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryRow() {
    return AnimatedPositioned(
      top: position ? 320 : 420,
      left: 25,
      right: 25,
      duration: const Duration(milliseconds: 400),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
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
      builder: (context) => ServiceHomePage(), // Ganti dengan halaman yang sesuai
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
      builder: (context) => babystrrers(), // Ganti dengan halaman yang sesuai
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
      builder: (context) => office(), // Ganti dengan halaman yang sesuai
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
      builder: (context) => kategoriPage(), // Ganti dengan halaman yang sesuai
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

  Widget category(String asset, String txt, double padding, VoidCallback onTap) {
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
        SizedBox(
          height: 5,
        ),
        Text(
          txt,
          style: TextStyle(
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
