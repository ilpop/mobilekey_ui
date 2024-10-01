import 'package:flutter/material.dart';
import 'package:mobilekey_ui/pages/home_page.dart'; // Import ScrollableListView
import 'package:mobilekey_ui/services/room_type_service.dart'; // Import RoomTypeService

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
    RoomTypeService roomTypeService = RoomTypeService();

    try {
      // Fetch the room types after successful login
      List<String> roomTypes = await roomTypeService.fetchRoomTypes();

      // Navigate to ScrollableListView and pass the room types as assets
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            phoneNumber: enteredPhone, // Use the entered phone number
            assets: roomTypes, // Room types fetched from the API
          ),
        ),
      );
    } catch (e) {
      print('Error fetching room types: $e');
      setState(() {
        _errorMessage =
            'An error occurred while fetching room types. Please try again.';
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
