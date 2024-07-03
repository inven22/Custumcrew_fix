import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:asistant_rumah/Services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:asistant_rumah/Screens/register_screen.dart'; // Tambahkan import untuk RegisterScreen
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';

  bool _isLoggingIn = false;

  loginPressed() async {
    if (_email.isNotEmpty && _password.isNotEmpty && !_isLoggingIn) {
      setState(() {
        _isLoggingIn = true;
      });
      http.Response response = await AuthServices.login(_email, _password);
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen(),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(responseMap['error'] ?? 'Password salah'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _isLoggingIn = false;
                    });
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        setState(() {
          _isLoggingIn = false;
        });
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter all required fields'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.transparent, // Hapus warna latar belakang AppBar
        elevation: 0,
        title: const Text(
          'Login',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Warna teks hitam
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green, Colors.white], // Warna hijau dan putih
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(19, 19, 19, 19), // Sedikit ke atas
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                size: 100,
                color: Colors.black, // Warna ikon
              ),
              const SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(20), // Lengkungan di setiap sisi
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                onChanged: (value) {
                  _email = value;
                },
              ),
              const SizedBox(height: 20),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(20), // Lengkungan di setiap sisi
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                onChanged: (value) {
                  _password = value;
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            RegisterScreen()), // Pindah ke halaman pendaftaran
                  );
                },
                child: Text(
                  'Don\'t have an account? Sign up here',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isLoggingIn ? null : loginPressed,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: _isLoggingIn
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Warna tombol biru
                  onPrimary: Colors.white, // Warna teks putih
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20), // Lengkungan di setiap sisi
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
