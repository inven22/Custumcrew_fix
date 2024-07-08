import 'package:flutter/material.dart';
import 'package:asistant_rumah/services/profile_services.dart';

class EditAccountScreen extends StatefulWidget {
  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  void loadProfile() async {
    setState(() {
      isLoading = true;
    });

    try {
      Map<String, dynamic> profileData =
          await ProfileServices.fetchProfileData();
      setState(() {
        nameController.text = profileData['user']['name'];
        emailController.text = profileData['user']['email'];
        alamatController.text = profileData['user']['alamat'] ?? '';
        phoneController.text = profileData['user']['phone'] ?? '';
      });
    } catch (e) {
      print('Error fetching profile: $e');
      // Handle error fetching profile
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void updateProfile() async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String alamat = alamatController.text;
    String phone = phoneController.text;

    try {
      var response = await ProfileServices.updateProfile(
        name: name,
        email: email,
        password: password,
        alamat: alamat,
        phone: phone,
      );

      if (response != null) {
        // Handle successful update
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update profile'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Handle exceptions
      print('Exception updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  TextField(
                    controller: alamatController,
                    decoration: InputDecoration(labelText: 'Alamat'),
                  ),
                  TextField(
                    controller: phoneController,
                    decoration: InputDecoration(labelText: 'Phone'),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: updateProfile,
                    child: Text('Update Profile'),
                  ),
                ],
              ),
            ),
    );
  }
}
