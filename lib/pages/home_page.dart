import 'package:flutter/material.dart';
import '../components/scrollable_list_view.dart';
import 'login_page.dart';
import 'payments_page.dart';
import 'shared_page.dart';

class HomePage extends StatefulWidget {
  final String phoneNumber;
  final List<dynamic> assets;

  const HomePage({super.key, required this.phoneNumber, required this.assets});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // List of pages to switch between
  List<Widget> get _pages {
    return [
      ScrollableListView(
        phoneNumber: widget.phoneNumber,
        assets: widget.assets, // Passing assets to ScrollableListView
      ),
      const FavoritesPage(),
      const HistoryPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 120,
            height: 120,
            child: Image.asset(
              'images/logo-small.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: const Text('WebKey.ID'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
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
            icon: Icon(Icons.share),
            label: 'Share',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payments',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
