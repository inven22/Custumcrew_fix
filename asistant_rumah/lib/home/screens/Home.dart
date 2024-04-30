import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:asistant_rumah/home/screens/SeeAll.dart';
import 'package:asistant_rumah/home/res/lists.dart';
import 'package:asistant_rumah/home/widgets/text_widget.dart' ;
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var opacity = 0.0;
  bool position=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();

      setState(() {

      });
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
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 30, left: 0, right:0),
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
                          TextWidget("Selamat datang", 17, Colors.black.withOpacity(.7),
                              FontWeight.bold),
                          TextWidget("Kiseki", 25, Colors.black, FontWeight.bold),
                        ],
                      ),
                      const Icon(Icons.phonelink_ring)
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
                          hintText: "   Cari Asistant rumah tangga"),
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
            // Gambar dari online
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.network(
                'https://media.istockphoto.com/vectors/volunteers-cleaning-beach-pickup-garbage-on-river-or-lake-shore-man-vector-id1310872620?k=20&m=1310872620&s=612x612&w=0&h=QNP_-Kl3tXY6ZHzq6RUuEXt0dH-NDiVA3udNeyPJ0Ns=',
                fit: BoxFit.cover,
                height: 150,
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
                  top: position?420:500,
                  left: 20,
                  right: 20, duration: const Duration(milliseconds: 400),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: opacity,
                    child: Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget("List Asistant Home", 25, Colors.black.withOpacity(.8), FontWeight.bold,letterSpace: 0,),
                      InkWell(
                        onTap: () async
                          {
                            animator();
                            setState(() {
                            });
                            // Timer(Duration(seconds: 1),() {
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) => SeeAll(),));
                            //   animator();
                            // },);
                            await Future.delayed(const Duration(milliseconds: 500));
                            await Navigator.push(context, MaterialPageRoute(builder:  (context) {
                              return SeeAll();
                            },));

                            setState(() {
                              animator();
                            });
                          },
                          child: TextWidget("Lihat semua", 15, Colors.blue.shade600.withOpacity(.8), FontWeight.bold,letterSpace: 0,)),
                    ],
                ),
              ),
                  )),
              doctorList(),
              Align(
                alignment: Alignment.bottomCenter,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: CurvedNavigationBar(

                        backgroundColor: Colors.white,
                        items: const [
                          Icon(Icons.home_filled,color: Colors.blue,size: 30,),
                          Icon(Icons.calendar_month_rounded,color: Colors.black,size: 30,),
                          Icon(Icons.whatshot_outlined,color: Colors.black,size: 30,),
                          Icon(Icons.account_circle_outlined,color: Colors.black,size: 30,),
                        ]),
                  ))

            ],
          ),
        ),
      ),
    );
  }



  Widget doctorList(){
    return AnimatedPositioned(
        top: position?460:550,
        left: 20,
        right: 20,
        duration: const Duration(milliseconds: 400),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: opacity,
          child: AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(milliseconds: 300),
            child: SizedBox(
              height: 270,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child:
                Column(
                  children: [
                    doctorCard(names[0], spacilality[0], images[0]),
                    doctorCard(names[1], spacilality[1], images[1]),
                    doctorCard(names[2], spacilality[2], images[2]),
                  ],
                ),

              ),
            ),
          ),
        )
    );
  }
  Widget doctorCard(String name,String specialist,AssetImage image){
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
            const SizedBox(width: 10,),
            CircleAvatar(
              radius: 30,
              backgroundImage: image,
              backgroundColor: Colors.blue,
            ),
            const SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(name, 20, Colors.black,FontWeight.bold,letterSpace: 0,),
                const SizedBox(height: 5,),
                TextWidget(specialist, 17, Colors.black,FontWeight.bold,letterSpace: 0,),
                const SizedBox(height: 5,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star,color: Colors.orangeAccent,),
                    Icon(Icons.star,color: Colors.orangeAccent,),
                    Icon(Icons.star,color: Colors.orangeAccent,),
                    Icon(Icons.star,color: Colors.orangeAccent,),
                    Icon(Icons.star,color: Colors.orangeAccent,),
                  ],
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.navigation_sharp,color: Colors.blue,),
            const SizedBox(width: 20,),
          ],
        ),
      ),
    );
  }
  Widget categoryRow(){
    return AnimatedPositioned(
        top: position? 320 : 420,
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
                category("assets/images/clean.png", "Cleaning",10),
                category("assets/images/baby.png", "Baby.C",15),
                category("assets/images/ofice.png", "Office.C",10),
                category("assets/images/app.png", "Lainnya",12),

              ],
            ),
          ),
        ));
  }
  Widget category(String asset,String txt,double padding){
    return Column(
      children: [
        InkWell(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            child: Container(
              padding:  EdgeInsets.all(padding),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Image(
                  image:
                  AssetImage(asset),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextWidget(
          txt,
          16,
          Colors.black,
          FontWeight.bold,
          letterSpace: 1,
        ),
      ],
    );
  }


}
