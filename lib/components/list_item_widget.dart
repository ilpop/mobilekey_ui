import 'package:flutter/material.dart';

class ListItemWidget extends StatelessWidget {
  final String text;
  final String imageUrl;
  final String? link;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final int index; // Add the index parameter to track the position

  const ListItemWidget({
    super.key,
    required this.text,
    required this.imageUrl,
    this.link,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.index, // Accept index as an argument
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Image.asset(
          imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            if (link != null)
              TextButton(
                onPressed: () {
                  // Handle link logic here
                },
                child: const Text(
                  'Reserve',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            // Change the icon based on whether it's the third item or not
            IconButton(
              icon: Icon(
                index % 3 == 2 // Every third item (index 2, 5, 8, etc.)
                    ? Icons
                        .attach_money // Example: money icon for every third item
                    : (isFavorite ? Icons.share : Icons.share_outlined),
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: onToggleFavorite,
            ),
          ],
        ),
      ),
    );
  }
}
