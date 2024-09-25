import 'package:flutter/material.dart';
import 'package:mobilekey_ui/components/list_item_widget.dart';
import 'package:mobilekey_ui/services/data_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DataService _dataService = DataService();
  List<dynamic> _items = [];
  List<String> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }


void _loadData() async {
  var items = await _dataService.loadJsonData();
  if (mounted) {
    setState(() {
      _items = items;
    });
  }
}


  void _toggleFavorite(String item) {
    setState(() {
      if (_favorites.contains(item)) {
        _favorites.remove(item);
      } else {
        _favorites.add(item);
      }
      _dataService.saveFavorites(_favorites);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: MediaQuery.of(context).size.width > 600
              ? 600
              : MediaQuery.of(context).size.width * 0.9,
          child: ScrollableListView(items: _items), // Use ScrollableListView here
        ),
      ),
    );
  }
}
