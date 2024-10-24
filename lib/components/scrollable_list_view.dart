import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScrollableListView extends StatefulWidget {
  final String phoneNumber;
  final List<String> assets;

  const ScrollableListView({
    super.key,
    required this.phoneNumber,
    required this.assets,
  });

  @override
  _ScrollableListViewState createState() => _ScrollableListViewState();
}

class _ScrollableListViewState extends State<ScrollableListView> {
  // Keep track of which items are favorited
  List<bool> _favorites = [];

  @override
  void initState() {
    super.initState();
    // Load favorites from SharedPreferences
    _loadFavorites();
  }

  // Load favorite status from SharedPreferences
  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteItems = prefs.getStringList('favorites');

    if (favoriteItems != null) {
      _favorites =
          widget.assets.map((asset) => favoriteItems.contains(asset)).toList();
    } else {
      _favorites = List<bool>.filled(widget.assets.length, false);
    }
    setState(() {});
  }

  // Save favorites to SharedPreferences
  Future<void> _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoritesList = widget.assets
        .asMap()
        .entries
        .where((entry) => _favorites[entry.key])
        .map((entry) => entry.value)
        .toList();

    await prefs.setStringList('favorites', favoritesList);
  }

  // Toggle the favorite status of an item
  void _toggleFavorite(int index) {
    setState(() {
      _favorites[index] = !_favorites[index];
    });
    _saveFavorites(); // Save the favorites after toggling
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the height for three items (assuming each item is around 80 pixels in height)
    double itemHeight = 70.0;
    double listHeight = itemHeight * 3; // For 3 items at a time

    return Center(
      child: SizedBox(
        height: listHeight, // Limit the height to fit 3 items
        child: ListView.builder(
          itemCount: widget.assets.length,
          itemBuilder: (context, index) {
            return Center(
              child: Card(
                child: ListTile(
                  trailing: IconButton(
                    icon: Icon(
                      _favorites[index]
                          ? Icons.favorite
                          : Icons
                              .favorite_border, // Toggle between filled and border icon
                      color: _favorites[index]
                          ? Colors.red // Change to red for filled icon
                          : null, // Default color for unfavored icon
                    ),
                    onPressed: () =>
                        _toggleFavorite(index), // Toggle favorite status
                  ),
                  title: Text(
                    widget.assets[index],
                    style: const TextStyle(color: Colors.black), // Black text
                  ),
                  subtitle: Text(
                    widget.phoneNumber,
                    style: const TextStyle(color: Colors.black), // Black text
                  ),
                  leading: CircleAvatar(
                    backgroundColor:
                        Colors.black, // Black background for avatars
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                          color: Colors.white), // White text inside avatars
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
