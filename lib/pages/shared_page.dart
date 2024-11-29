import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPage extends StatefulWidget {
  const SharedPage({super.key});

  @override
  SharedPageState createState() => SharedPageState();
}

class SharedPageState extends State<SharedPage> {
  List<String> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _favorites = prefs.getStringList('favorites') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _favorites.isEmpty
          ? const Center(child: Text('No Shared Locks.'))
          : ListView.builder(
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_favorites[index]),
                );
              },
            ),
    );
  }
}
