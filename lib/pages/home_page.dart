import 'package:flutter/material.dart';
import 'package:mobilekey_ui/components/scrollable_list_view.dart';
import 'package:mobilekey_ui/pages/favorites_page.dart';
import 'package:mobilekey_ui/pages/history_page.dart';
import 'package:mobilekey_ui/pages/login_page.dart';

class HomePage extends StatefulWidget {
  final String phoneNumber;
  final List<String> assets;

  const HomePage({super.key, required this.phoneNumber, required this.assets});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // List of pages to switch between
  // A list of pages to display, passing the phone number and assets to the home page
  List<Widget> get _pages {
    return [
      ScrollableListView(
        phoneNumber: widget.phoneNumber,
        assets: widget.assets,
      ),
      const FavoritesPage(), // Favorites Page (Placeholder)
      const HistoryPage(), // History Page (Placeholder)
    ];
  }

  // Function to handle bottom navigation item taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Function to handle logout action
  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => const LoginPage()), // Navigate back to login
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MobileKey'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout, // Handle logout
            tooltip: 'Logout',
          ),
        ],
      ),
      body: _pages[_selectedIndex], // Display the selected page

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Handle the navigation tap
      ),
    );
  }
}
