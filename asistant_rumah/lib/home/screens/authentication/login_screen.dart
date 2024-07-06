import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:asistant_rumah/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:asistant_rumah/home/screens/authentication/register_screen.dart';
import 'package:asistant_rumah/home/screens/dashboard/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const Home(),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(responseMap['error'] ?? 'Password salah'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _isLoggingIn = false;
                    });
                  },
                  child: const Text('OK'),
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
            title: const Text('Error'),
            content: const Text('Please enter all required fields'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
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
        decoration: const BoxDecoration(
          // ignore: unnecessary_const
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(19, 19, 19, 19), // Sedikit ke atas
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
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
                    borderSide: const BorderSide(color: Colors.black),
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
                    borderSide: const BorderSide(color: Colors.black),
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
                            const RegisterScreen()), // Pindah ke halaman pendaftaran
                  );
                },
                child: const Text(
                  'tidak memiliki akun? Daftar disini',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isLoggingIn ? null : loginPressed,
                // ignore: sort_child_properties_last
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: _isLoggingIn
                      ? const CircularProgressIndicator(
                          valueColor:
                              // ignore: unnecessary_const
                              const AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const Text(
                          'Log In',
                          // ignore: unnecessary_const
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                style: ElevatedButton.styleFrom(
                  // ignore: deprecated_member_use
                  primary: Colors.blue, // Warna tombol biru
                  // ignore: deprecated_member_use
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
