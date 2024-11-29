import 'package:flutter/material.dart';
import 'asset_item.dart'; // Import AssetItem here

class ScrollableListView extends StatefulWidget {
  final String phoneNumber;
  final List<dynamic> assets;
  final Map<String, dynamic> identityInfo;

  const ScrollableListView({
    super.key,
    required this.phoneNumber,
    required this.assets,
    required this.identityInfo,
  });

  @override
  ScrollableListViewState createState() => ScrollableListViewState();
}

class ScrollableListViewState extends State<ScrollableListView>
    with TickerProviderStateMixin {
  late List<bool> _unlocked;
  late List<AnimationController> _shakeControllers;

  @override
  void initState() {
    super.initState();
    _initializeState();
  }

  @override
  void dispose() {
    // Dispose all animation controllers
    for (var controller in _shakeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initializeState() {
    _unlocked = List<bool>.filled(widget.assets.length, false);
    _shakeControllers = widget.assets.map((_) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      );
    }).toList();
  }

  void _toggleLock(int index) {
    setState(() {
      _createShakeAnimation(index);
      _unlocked[index] = !_unlocked[index];
    });
    // If unlocked, set a 5-second delay to lock it again
    if (_unlocked[index]) {
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            _unlocked[index] = false; // Lock the item again
          });
        }
      });
    }
  }

  Animation<double> _createShakeAnimation(int index) {
    return Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(
        parent: _shakeControllers[index],
        curve: Curves.elasticInOut,
      ),
    );
  }

  void _shakeItem(int index) {
    _shakeControllers[index].forward(from: 0.0);
    _shakeControllers[index].addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _shakeControllers[index].reset();
      }
    });
    _toggleLock(index);
  }

  Widget _buildIdentityInfo() {
    final identity = widget.identityInfo;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Identity Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Created: ${identity['created']}'),
          Text('Modified: ${identity['modified']}'),
          Text('State: ${identity['state']}'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double avatarSize = size.height * 0.05;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIdentityInfo(),
        const Divider(), // Separator between header and list
        Expanded(
          child: ListView.builder(
            itemCount: widget.assets.length,
            itemBuilder: (context, index) {
              final asset = widget.assets[index];

              return AssetItem(
                asset: asset,
                unlocked: _unlocked[index],
                shakeController: _shakeControllers[index],
                avatarSize: avatarSize,
                onTap: () => _shakeItem(index),
                trailingIcons: _getTrailingIcons(index),
              );
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _getTrailingIcons(int index) {
    List<Widget> icons = [];

    if (index % 3 == 2) {
      icons.add(
        IconButton(
          icon: const Icon(Icons.payment, color: Colors.black),
          onPressed: () => print("Payment icon pressed for index $index"),
        ),
      );
    }

    if (index % 4 == 3) {
      icons.add(
        IconButton(
          icon: Image.asset(
            'assets/images/bitcoin-black-icon.png',
            width: 24,
            height: 24,
          ),
          onPressed: () => print("Bitcoin icon pressed for index $index"),
        ),
      );
    }

    icons.add(
      IconButton(
        icon: const Icon(Icons.share, color: Colors.black),
        onPressed: () => print("Shared item at index $index"),
      ),
    );

    return icons;
  }
}
