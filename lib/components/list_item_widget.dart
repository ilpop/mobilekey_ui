import 'package:flutter/material.dart';

class ListItemWidget extends StatelessWidget {
  final String text;
  final String imageUrl;
  final String? link;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final int index;

  const ListItemWidget({
    super.key,
    required this.text,
    required this.imageUrl,
    this.link,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.index,
  });

  // IconData _getIcon() {
  //   if (index % 3 == 2) {
  //     return Icons.attach_money; // Money icon for every third item
  //   }
  //   return isFavorite ? Icons.share : Icons.share_outlined;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2.0),
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
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
          ],
        ),
      ),
    );
  }
}
