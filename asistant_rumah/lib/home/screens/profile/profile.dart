import 'dart:async';
import 'package:flutter/material.dart';
import 'package:asistant_rumah/home/widgets/text_widget.dart';
import 'package:asistant_rumah/home/screens/order/oppointment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Profile extends StatefulWidget {
  final AssetImage? image;
  final String? name;
  final String? speciality;
  final String? biography;
  final int? order;
  final String? email;
  final int? id;
  const Profile({
    Key? key,
    required this.image,
    required this.name,
    required this.speciality,
    required this.order,
    required this.biography,
    required this.email,
    required this.id,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var animate = false;
  var opacity = 0.0;
  late Size size;
  double averageRating = 0.0;
  int totalOrder = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      fetchAverageRating();
      fetchTotalOrder();
      animator();
    });
  }

  animator() {
    if (opacity == 0.0) {
      opacity = 1;
      animate = true;
    } else {
      opacity = 0.0;
      animate = false;
    }
    setState(() {});
  }

  void fetchAverageRating() async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/api/getRatings/${widget.id}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        averageRating = data['average_rating'] ??
            0.0; // Update averageRating state variable
        print(averageRating);
      });
    } else {
      print('Failed to load average rating');
    }
  }

  void fetchTotalOrder() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/getTotalOrder/${widget.id}'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        totalOrder = data['total_order'] ?? 0;
      });
    } else {
      print('Failed to load total order');
    }
    print(totalOrder);
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 60),
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            AnimatedPositioned(
                top: 1,
                right: animate ? -100 : -200,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Container(
                    height: size.height / 2,
                    width: size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: widget.image ??
                                const AssetImage(
                                    'assets/placeholder_image.png'),
                            fit: BoxFit.cover)),
                  ),
                )),
            AnimatedPositioned(
                left: animate ? 1 : -100,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Container(
                    padding: const EdgeInsets.only(top: 80, left: 20),
                    height: size.height / 2,
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          widget.name ?? "",
                          25,
                          Colors.black,
                          FontWeight.bold,
                          letterSpace: 0,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextWidget(
                          widget.speciality ?? "",
                          15,
                          Colors.black.withOpacity(.6),
                          FontWeight.bold,
                          letterSpace: 0,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const SizedBox(
                                height: 60,
                                width: 60,
                                child: Center(
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      "Rating",
                                      17,
                                      Colors.black.withOpacity(.5),
                                      FontWeight.bold,
                                      letterSpace: 0,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextWidget(
                                      "${averageRating.toStringAsFixed(1)} from 5",
                                      23,
                                      Colors.black,
                                      FontWeight.bold,
                                      letterSpace: 0,
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const SizedBox(
                                height: 60,
                                width: 60,
                                child: Center(
                                  child: Icon(
                                    Icons.people_rounded,
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      "Order",
                                      17,
                                      Colors.black.withOpacity(.5),
                                      FontWeight.bold,
                                      letterSpace: 0,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextWidget(
                                      totalOrder.toString(),
                                      23,
                                      Colors.black,
                                      FontWeight.bold,
                                      letterSpace: 0,
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )),
            AnimatedPositioned(
                top: 300,
                right: animate ? 1 : -50,
                duration: const Duration(milliseconds: 400),
                child: Container(
                  height: 150,
                  width: size.width / 2,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Colors.white.withOpacity(.1),
                        Colors.white,
                        Colors.white
                      ])),
                )),
            AnimatedPositioned(
                top: animate ? 380 : 480,
                left: 1,
                right: 1,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 40),
                    height: size.height / 5,
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                            "Biography", 25, Colors.black, FontWeight.bold),
                        const SizedBox(
                          height: 20,
                        ),
                        TextWidget(
                          widget.biography ?? "",
                          15,
                          Colors.black.withOpacity(.5),
                          FontWeight.normal,
                          letterSpace: 0,
                        ),
                      ],
                    ),
                  ),
                )),
            AnimatedPositioned(
                top: animate ? 465 : 560,
                right: 80,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: TextWidget(
                      " Lebih lengkap",
                      15,
                      Colors.blue,
                      FontWeight.bold,
                      letterSpace: 0,
                    ))),
            AnimatedPositioned(
                left: 20,
                right: 20,
                bottom: animate ? 80 : -20,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  opacity: opacity,
                  duration: const Duration(milliseconds: 400),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    height: 130,
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget("Jadwal", 25, Colors.black, FontWeight.bold),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextWidget(
                                      "19",
                                      15,
                                      Colors.black,
                                      FontWeight.bold,
                                      letterSpace: 0,
                                    ),
                                    TextWidget(
                                      "Thu",
                                      15,
                                      Colors.black,
                                      FontWeight.bold,
                                      letterSpace: 0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextWidget(
                                      "20",
                                      15,
                                      Colors.black,
                                      FontWeight.bold,
                                      letterSpace: 0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextWidget(
                                      "21",
                                      15,
                                      Colors.black,
                                      FontWeight.bold,
                                      letterSpace: 0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextWidget(
                                      "22",
                                      15,
                                      Colors.black,
                                      FontWeight.bold,
                                      letterSpace: 0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )),
            AnimatedPositioned(
                bottom: animate ? 15 : -80,
                left: 30,
                right: 30,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: InkWell(
                    onTap: () async {
                      animator();
                      await Future.delayed(const Duration(milliseconds: 400));
                      // ignore: use_build_context_synchronously
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Oppointment(
                                    id: widget.id ?? 0,
                                  )));
                      animator();
                    },
                    child: Container(
                      height: 65,
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue.shade900,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                            "Jadwalkan pesanan",
                            18,
                            Colors.white,
                            FontWeight.w500,
                            letterSpace: 1,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white,
                            size: 18,
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white.withOpacity(.5),
                            size: 18,
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white.withOpacity(.2),
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            AnimatedPositioned(
                top: animate ? 20 : 100,
                left: 20,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                    opacity: opacity,
                    duration: const Duration(milliseconds: 400),
                    child: InkWell(
                      onTap: () {
                        animator();
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new_sharp,
                        color: Colors.black,
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
