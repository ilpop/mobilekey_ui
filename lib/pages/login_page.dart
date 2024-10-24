import 'package:flutter/material.dart';
import 'package:mobilekey_ui/pages/home_page.dart';
import 'package:mobilekey_ui/services/data_service.dart';
import 'package:mobilekey_ui/services/json_parser.dart'; // Import JsonParser

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  String? _errorMessage;

  // Function to log in and fetch room types
  Future<void> _login() async {
    String enteredPhone = _phoneController.text.trim();

    // Check if the phone number is empty
    if (enteredPhone.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a phone number.';
      });
      return;
    }

    // Simulating login success for demonstration
    DataService dataService = DataService();
    JsonParser jsonParser = JsonParser();

    try {
      // Fetch the room data
      List<dynamic> roomData = await dataService.loadJsonData();

      // Extract the assets from the room data
      List<String> rooms = roomData
          .map((item) {
            Map<String, dynamic> parsedData =
                jsonParser.extractPhoneNumberAndAssets(item);
            return parsedData['assets']
                .join(', '); // Join the assets list into a string
          })
          .toList()
          .cast<String>();

      // Navigate to HomePage with the phone number and room types
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            phoneNumber: enteredPhone, // Use the entered phone number
            assets: rooms, // Pass the room assets to HomePage
          ),
        ),
      );
    } catch (e) {
      print('Error fetching room types: $e');
      setState(() {
        _errorMessage =
            'An error occurred while fetching rooms. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Enter your phone number',
                errorText: _errorMessage,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
