import 'package:asistant_rumah/services/household_assistant_services.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:asistant_rumah/home/widgets/setting_item.dart';
import 'package:asistant_rumah/services/profile_services.dart';
import 'package:asistant_rumah/home/widgets/forward_button.dart';
import 'package:asistant_rumah/home/screens/profile/edit_screen.dart';
import 'package:asistant_rumah/home/screens/authentication/login_screen.dart';
import 'package:asistant_rumah/Asistant_art/daftar_art/daftarart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String _userName = 'Loading...';
  String _userEmail = '';
  String _userRole = '';
  String _speciality = '';

  @override
  void initState() {
    super.initState();
    fetchProfile();
    fetchHouseholdAssistantData();
  }

  fetchProfile() async {
    try {
      Map<String, dynamic> profileData =
          await ProfileServices.fetchProfileData();
      setState(() {
        _userName = profileData['user']['name'];
        _userEmail = profileData['user']['email'];
        _userRole = profileData['user']['role'];
      });
    } catch (e) {
      setState(() {
        _userName = 'Error';
        _userEmail = '';
      });
      // ignore: avoid_print
      print('Error fetching profile: $e');
    }
  }

  fetchHouseholdAssistantData() async {
    try {
      http.Response response =
          await HouseholdAssistantServices.getHouseholdAssistantData();
      print("status code:${response.statusCode}");
      print("ini ii ${jsonDecode(response.body)}");

      if (response.statusCode == 200) {
        Map<String, dynamic> householdData = jsonDecode(response.body);
        setState(() {
          _speciality = householdData['speciality'];
        });
      } else if (response.statusCode == 404) {
        throw Exception('Household assistant data not found');
      } else {
        throw Exception(
            'Failed to load household assistant data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching household assistant data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 80,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Image.asset("assets/images/avatar.png",
                        width: 70, height: 70),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _userRole == 'household_assistant'
                              ? '$_userName (assistant)'
                              : _userName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _userEmail,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _speciality,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    ForwardButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditAccountScreen(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Language",
                icon: Ionicons.earth,
                bgColor: Colors.orange.shade100,
                iconColor: Colors.orange,
                value: "Indonesia",
                onTap: () {},
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Notifications",
                icon: Ionicons.notifications,
                bgColor: Colors.blue.shade100,
                iconColor: Colors.blue,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Help",
                icon: Ionicons.nuclear,
                bgColor: Colors.red.shade100,
                iconColor: Colors.red,
                onTap: () {},
              ),
              if (_userRole == 'user')
                Column(
                  children: [
                    const SizedBox(height: 20),
                    SettingItem(
                      title: "Daftar sebagai Hausehold",
                      icon: Ionicons.notifications,
                      bgColor: Colors.blue.shade100,
                      iconColor: Colors.blue,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const daftarart(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Logout",
                icon: Ionicons.notifications,
                bgColor: Colors.blue.shade100,
                iconColor: Colors.blue,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
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
}
