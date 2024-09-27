import 'package:flutter/material.dart'; // Import Flutter material package
import 'package:mobilekey_ui/components/list_item_widget.dart'; // Import ListItemWidget

class ScrollableListView extends StatelessWidget {
  final List<dynamic> items;
  final List<String> favorites;
  final Function(String) onToggleFavorite;

  const ScrollableListView({
    super.key,
    required this.items,
    required this.favorites,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    // Show only up to 3 items
    final displayItems = items.take(3).toList(); // Limit to 3 items

    return SizedBox(
      height: 180, // Adjust the height based on your item size
      child: ListView.builder(
        itemCount: displayItems.length,
        itemBuilder: (context, index) {
          var item = displayItems[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListItemWidget(
              text: item['text'],
              imageUrl: item['image'],
              link: item['link'],
              isFavorite: favorites.contains(item['text']),
              onToggleFavorite: () => onToggleFavorite(item['text']),
            ),
          );
        },
      ),
    );
  }
}
