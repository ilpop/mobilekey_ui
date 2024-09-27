import 'package:flutter/material.dart';
import 'package:mobilekey_ui/components/scrollable_list_view.dart'; // Import the ScrollableListView component
import 'package:mobilekey_ui/pages/favorites_page.dart'; // Import Favorites Page
import 'package:mobilekey_ui/pages/history_page.dart'; // Import History Page

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // List of pages to switch between
  final List<Widget> _pages = [
    const ScrollableListView(), // Home Page content
    const FavoritesPage(), // Placeholder Favorites Page
    const HistoryPage(), // Placeholder History Page
  ];

  // Function to handle bottom navigation item taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MobileKey'),
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
