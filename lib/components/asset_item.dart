import 'package:flutter/material.dart';

class AssetItem extends StatelessWidget {
  final Map<String, dynamic> asset;
  final bool unlocked;
  final AnimationController shakeController;
  final double avatarSize;
  final VoidCallback onTap;
  final List<Widget> trailingIcons;

  const AssetItem({
    super.key,
    required this.asset,
    required this.unlocked,
    required this.shakeController,
    required this.avatarSize,
    required this.onTap,
    required this.trailingIcons,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: AnimatedBuilder(
          animation: shakeController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(shakeController.value, 0),
              child: child,
            );
          },
          child: Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(8.0),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: trailingIcons,
              ),
              title: Text(
                asset['assetName'] ?? 'Unknown',
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Allowed: ${asset['allowed']}'),
                  Text('Asset ID: ${asset['assetId']}'),
                  Text('Provider: ${asset['provider']}'),
                ],
              ),
              leading: CircleAvatar(
                radius: avatarSize,
                backgroundColor: Colors.black,
                child: Icon(
                  unlocked ? Icons.lock_open : Icons.lock,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
