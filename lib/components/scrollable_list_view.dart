import 'package:flutter/material.dart';

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
    // Initialize all items as not favorited (false)
    _favorites = List<bool>.filled(widget.assets.length, false);
  }

  // Toggle the favorite status of an item
  void _toggleFavorite(int index) {
    setState(() {
      _favorites[index] = !_favorites[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the height for three items (assuming each item is around 80 pixels in height)
    double itemHeight = 70.0;
    double listHeight = itemHeight * 6; // For 3 items at a time

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
                          ? Colors.black
                          : null, // Fill icon if favorited
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
