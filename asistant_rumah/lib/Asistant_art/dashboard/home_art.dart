import 'dart:async';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:asistant_rumah/Asistant_art/profile/Setting_art.dart';
import 'package:asistant_rumah/Asistant_art/chat/pesan_list.dart';
import 'package:asistant_rumah/services/profile_services.dart';

class Homeart extends StatefulWidget {
  const Homeart({Key? key}) : super(key: key);

  @override
  State<Homeart> createState() => _HomeState();
}

class _HomeState extends State<Homeart> {
  double opacity = 0.0;
  bool position = false;
  String _userName = 'Loading...';
  String _token = '';
  List<String> orders = ['Order 1', 'Order 2']; // Example orders

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _toggleAnimationState();
      fetchProfile();
      _loadToken();
    });
  }

  void _toggleAnimationState() {
    setState(() {
      opacity = opacity == 1 ? 0 : 1;
      position = !position;
    });
  }

  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token') ?? '';
      print('Token: $_token'); // Print token for debugging
    });
  }

  Future<void> fetchProfile() async {
    try {
      Map<String, dynamic> profileData = await ProfileServices.fetchProfileData();
      setState(() {
        _userName = profileData['user']['name'];
      });
    } catch (e) {
      setState(() {
        _userName = 'Error';
      });
      print('Error fetching profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: topPadding + 30, left: 16, right: 16),
          height: screenHeight,
          width: screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAnimatedWelcome(),
              SizedBox(height: 20),
              _buildAnimatedSearchBar(),
              SizedBox(height: 20),
              _buildAnimatedImageCard(screenWidth),
              SizedBox(height: 20),
              _buildInfoCards(screenWidth),
              SizedBox(height: 20),
              Expanded(child: Container()), // This ensures the bottom nav bar stays at the bottom
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildAnimatedWelcome() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      top: position ? 0 : 50,
      left: 0,
      right: 0,
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => NotificationPage(),
                //   ),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedSearchBar() {
    return AnimatedPositioned(
      top: position ? 80 : 140,
      left: 0,
      right: 0,
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
    );
  }

  Widget _buildAnimatedImageCard(double screenWidth) {
    return AnimatedPositioned(
      top: position ? 150 : 220,
      right: 0,
      left: 0,
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
            width: screenWidth,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/home.jpg', // Use Image.asset for local images
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAssistantCard(String name, String specialist, String price, AssetImage image) {
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
            const SizedBox(width: 10),
            CircleAvatar(
              radius: 30,
              backgroundImage: image,
              backgroundColor: Colors.blue,
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  specialist,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
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
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCards(double screenWidth) {
    return AnimatedPositioned(
      top: position ? 300 : 360,
      left: 0,
      right: 0,
      duration: const Duration(milliseconds: 400),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: opacity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: _buildInfoCard("Nama", _userName),
            ),
            SizedBox(width: screenWidth * 0.02), // Responsive spacing
            Expanded(
              child: _buildInfoCard("Jumlah Order : 32", orders.length.toString()), // Display number of orders
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 120,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        items: [
          GestureDetector(
            onTap: () {},
            child: Icon(Icons.home_filled, color: Colors.blue, size: 30),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => pesanlist(),
                ),
              );
            },
            child: Icon(Icons.message, color: Colors.black, size: 30),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => settingart(),
                ),
              );
            },
            child: Icon(Icons.account_circle_outlined, color: Colors.black, size: 30),
          ),
        ],
      ),
    );
  }
}
