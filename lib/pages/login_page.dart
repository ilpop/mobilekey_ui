import 'package:flutter/material.dart';
import '../services/graphql_client.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  String? _errorMessage;

  // Function to validate the mobile number from GraphQL data
  Future<void> _login() async {
    String enteredPhone = _phoneController.text.trim();

    try {
      if (enteredPhone == "1234") {
        // Check if the phone number is "1234"
        final result = await GraphQLConfig
            .fetchData(); // Fetch data after successful login

        if (result.hasException) {
          setState(() {
            _errorMessage = 'Error: ${result.exception.toString()}';
          });
          return;
        }

        var assets = result.data?['assets'];
        if (assets != null && assets.isNotEmpty) {
          // Navigate to the HomePage after successful login and data fetch
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                phoneNumber: enteredPhone, // Pass the phone number
                assets: List.from(assets), // Pass the assets list
              ),
            ),
          );
        } else {
          setState(() {
            _errorMessage = 'No assets found.';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Invalid phone number.';
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        _errorMessage = 'An error occurred. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
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
            ),
          ],
        ),
      ),
    );
  }
}
