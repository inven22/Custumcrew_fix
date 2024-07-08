import 'package:flutter/material.dart';
import 'package:asistant_rumah/services/register_household_services.dart';

class RegisterHouseholdAssistantScreen extends StatefulWidget {
  @override
  _RegisterHouseholdAssistantScreenState createState() =>
      _RegisterHouseholdAssistantScreenState();
}

class _RegisterHouseholdAssistantScreenState
    extends State<RegisterHouseholdAssistantScreen> {
  final TextEditingController _specialityController = TextEditingController();

  Future<void> _registerHouseholdAssistant() async {
    try {
      final response =
          await RegisterHouseholdServices.registerHouseholdAssistant(
              _specialityController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to register as household assistant')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register as Household Assistant'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _specialityController,
              decoration: InputDecoration(labelText: 'Speciality'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerHouseholdAssistant,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
