import 'package:flutter/material.dart';
import 'package:mobilekey_ui/services/json_parser.dart';
import 'package:mobilekey_ui/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  String? _errorMessage;

  // Function to validate the mobile number from the JSON data
  Future<void> _login() async {
    String enteredPhone = _phoneController.text.trim();
    JsonParser jsonParser = JsonParser();
    String assetPath = 'assets/data.json';

    try {
      List<dynamic> jsonData = await jsonParser.loadJsonFromAssets(assetPath);

      for (var item in jsonData) {
        if (item['field_phone'] == enteredPhone) {
          Map<String, dynamic> extractedData =
              jsonParser.extractPhoneNumberAndAssets(item);

          // If the phone number is found, navigate to the home page and pass the data
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                phoneNumber: extractedData['phoneNumber'],
                assets: extractedData['assets'],
              ),
            ),
          );
          return;
        }
      }

      // If phone number not found, show an error
      setState(() {
        _errorMessage = 'Phone number not found.';
      });
    } catch (e) {
      print('Error loading data: $e');
      setState(() {
        _errorMessage = 'An error occurred. Please try again.';
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
              child: const Text('Login'),
              style: ElevatedButton.styleFrom(),
            ),
          ],
        ),
      ),
    );
  }
}
