import 'dart:async';

import 'package:flutter/material.dart';
import 'package:asistant_rumah/home/screens/Home.dart';
import 'package:asistant_rumah/home/widgets/text_widget.dart';
import 'package:asistant_rumah/home/res/lists.dart';
import 'Profile.dart';
import 'Chat.dart';

class moreart extends StatefulWidget {
  @override
  State<moreart> createState() => _SeeAllState();
}

class _SeeAllState extends State<moreart> {
  var opacity = 0.0;
  bool position=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();
    });
  }

  animator() {
    if (opacity == 1) {
      opacity = 0;
      position=false;
    } else {
      opacity = 1;
      position=true;
    }
    setState(() {});
  }
  

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 70),
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 400),
              top: position ? 1 : 50,
              left: 20,
              right: 20,
              child: upperRow(),
            ),
            AnimatedPositioned(
                top: position ? 60 : 120,
                right: 20,
                left: 20,
                duration: Duration(milliseconds: 300),
                child: find()),
            AnimatedPositioned(
                top: position ? 390 : 450,
                right: 20,
                left: 20,
                duration: Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  opacity: opacity,
                  duration: Duration(milliseconds: 400),
                  child: Container(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          "List Asistant",
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
                )),
            AnimatedPositioned(
                top: position ? 430 : 500,
                left: 20,
                right: 20,
                duration: Duration(milliseconds: 500),
                child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: opacity,
                    child: Container(
                      height: 350,
                      child: ListView.builder(
                        itemCount: 7,
                        itemBuilder:
                            (context, index) => InkWell(
                          onTap: () async {
                            animator();
                            await Future.delayed(
                                const Duration(milliseconds: 500));
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Profile(image: images[index], name: names[index], speciality: spacilality[index]),
                                ));
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
                                  const SizedBox(width: 20,),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: images[index],
                                    backgroundColor: Colors.blue,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      TextWidget(
                                        names[index],
                                        20,
                                        Colors.black,
                                        FontWeight.bold,
                                        letterSpace: 0,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextWidget(
                                        spacilality[index],
                                        17,
                                        Colors.black,
                                        FontWeight.bold,
                                        letterSpace: 0,
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
                                  const SizedBox(width: 20,),
                                ],
                              ),
                            ),
                          ),
                        ),),
                    )
                )),
          ],
        ),
      ),
    );
  }

  Widget find(){
  return AnimatedOpacity(
    duration: const Duration(milliseconds: 400),
    opacity: opacity,
    child: Card(
      margin: EdgeInsets.all(4), // Menambahkan margin untuk memperkecil ukuran card
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)), // Mengurangi ukuran borderRadius
      child: Container(
        height: 250, // Mengurangi tinggi card
        width: MediaQuery.of(context).size.width * 0.8, // Mengurangi lebar card
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue.shade700,
                  Colors.blue.shade900,
                  Colors.blue.shade900,
                ])),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                top: 5,
                right: 5,
                child: Icon(
                  Icons.close_outlined,
                  color: Colors.white,
                  size: 15,
                )
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Cari asistant',
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                  ),
                  // Add your search functionality here
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  Widget upperRow(){
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
                    ));
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
           )
        ],
      ),
    );
  }

}
