import 'dart:async';

import 'package:flutter/material.dart';
import 'package:asistant_rumah/home/screens/Home.dart';
import 'package:asistant_rumah/home/widgets/text_widget.dart';
import 'package:asistant_rumah/home/res/lists.dart';
// import 'Profile.dart';
import 'Chat.dart';

class pesan extends StatefulWidget {
  @override
  State<pesan> createState() => _SeeAllState();
}

class _SeeAllState extends State<pesan> {
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
      padding: EdgeInsets.only(top: 20),
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 40),
            top: position ? 20 : 50, // Nilai top diubah untuk menyesuaikan posisi awal
            left: 40,
            right: 20,
            child: upperRow(),
          ),
          
          AnimatedPositioned(
            top: position ? 80 : 140, // Nilai top diubah untuk menyesuaikan posisi awal
            right: 40,
            left: 40,
            duration: Duration(milliseconds: 40),
            child: AnimatedOpacity(
              opacity: opacity,
              duration: Duration(milliseconds: 40),
              child: Container(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      "List Chat",
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
            top: position ? 110 : 170, // Nilai top diubah untuk menyesuaikan posisi awal
            left: 20,
            right: 20,
            duration: Duration(milliseconds: 50),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 50),
              opacity: opacity,
              child: Container(
                height: 630,
                child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () async {
                      animator();
                      await Future.delayed(const Duration(milliseconds: 50));
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => Chat(image: images[index], name: names[index], specialist: spacilality[index])

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
                              mainAxisAlignment: MainAxisAlignment.center,
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
                            const SizedBox(width: 40,),
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

  
  Widget upperRow(){
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              animator();
              Timer(const Duration(milliseconds: 60), () {
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
          TextWidget("Message", 25, Colors.black, FontWeight.bold),
          const Icon(
            Icons.message,
            color: Colors.black,
            size: 25,
          )
        ],
      ),
    );
  }

}
