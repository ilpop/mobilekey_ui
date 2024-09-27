import 'package:flutter/material.dart';
import 'package:mobilekey_ui/components/scrollable_list_view.dart'; // Import the ScrollableListView component

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MobileKey'),
      ),
      body: const ScrollableListView(), // Use the ScrollableListView here
    );
  }
}
