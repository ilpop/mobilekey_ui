import 'package:flutter/material.dart';
import '/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Set the primary color to black and text to white
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black, // Black background for AppBar
          foregroundColor: Colors.white, // White text for AppBar
          elevation: 0, // Flat style (no shadow)
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor:
              Colors.black, // Black background for BottomNavigationBar
          selectedItemColor: Colors.white, // White selected icon/text
          unselectedItemColor: Colors.grey, // Grey unselected icon/text
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black), // Black body text
          bodyMedium:
              TextStyle(color: Colors.black), // Black body text (smaller)
          titleLarge: TextStyle(
            color: Colors.white, // White AppBar title text
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // White icons
        ),
      ),
      home: const HomePage(),
    );
  }
}
