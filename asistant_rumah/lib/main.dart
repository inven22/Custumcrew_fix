import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:asistant_rumah/services/globals.dart';
import 'package:asistant_rumah/services/token_services.dart';
import 'package:asistant_rumah/home/screens/dashboard/home.dart';
import 'package:asistant_rumah/home/screens/authentication/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InitialScreen(),
    );
  }
}

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  _checkToken() async {
    String? token = await TokenServices.getToken();
    if (token != null) {
      bool isValid = await _validateToken(token);
      if (isValid) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      } else {
        await TokenServices.clearToken();
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<bool> _validateToken(String token) async {
    var url = Uri.parse('${baseURL}auth/validate-token');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Map responseMap = jsonDecode(response.body);
      return responseMap['valid'] == true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Container(), // Sementara loading, tampilkan indikator loading
      ),
    );
  }
}
