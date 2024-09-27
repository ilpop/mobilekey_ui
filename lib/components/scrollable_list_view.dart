import 'package:flutter/material.dart';

class ScrollableListView extends StatelessWidget {
  final String phoneNumber;
  final List<String> assets;

  const ScrollableListView(
      {super.key, required this.phoneNumber, required this.assets});

  @override
  Widget build(BuildContext context) {
    // Calculate the height for three items (assuming each item is around 80 pixels in height)
    double itemHeight = 80.0;
    double listHeight = itemHeight * 3; // For 3 items at a time

    return Center(
      child: SizedBox(
        height: listHeight, // Limit the height to fit 3 items
        child: ListView.builder(
          itemCount: assets.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(
                  assets[index],
                  style: const TextStyle(color: Colors.black), // Black text
                ),
                subtitle: Text(
                  phoneNumber,
                  style: const TextStyle(color: Colors.black), // Black text
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.black, // Black background for avatars
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                        color: Colors.white), // White text inside avatars
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
