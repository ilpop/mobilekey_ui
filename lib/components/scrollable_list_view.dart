import 'package:flutter/material.dart';

class ScrollableListView extends StatefulWidget {
  final String phoneNumber;
  final List<dynamic> assets; // Accept assets as a List
  final identityInfo;

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
  final List<AnimationController> _shakeControllers = [];

  @override
  void initState() {
    super.initState();
    _initializeStates();
    _initializeShakeControllers();
  }

  Future<void> _initializeStates() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //List<String>? favoriteItems = prefs.getStringList('favorites');

    setState(() {
      // _favorites = widget.assets
      //     .map((asset) => favoriteItems?.contains(asset['assetName']) ?? false)
      //     .toList();
      _unlocked = List<bool>.filled(widget.assets.length, false);
    });
  }

  void _initializeShakeControllers() {
    _shakeControllers.addAll(widget.assets.map(
      (_) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      ),
    ));
  }

  void _toggleLock(int index) {
    setState(() {
      _createShakeAnimation(index);
      _unlocked[index] = !_unlocked[index];
    });
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

  List<Widget> _getTrailingIcons(int index) {
    List<Widget> icons = [];

    // Add payment icon for every third item
    if (index % 3 == 2) {
      icons.add(
        IconButton(
          icon: const Icon(Icons.payment, color: Colors.black),
          onPressed: () {
            // Handle payment icon press
            print("Payment icon pressed for index $index");
          },
        ),
      );
    }

    // Add bitcoin icon for every fourth item
    if (index % 4 == 3) {
      icons.add(
        IconButton(
          icon: Image.asset(
            'assets/images/bitcoin-black-icon.png', // Bitcoin icon
            width: 24,
            height: 24,
          ),
          onPressed: () {
            // Handle bitcoin icon press
            print("Bitcoin icon pressed for index $index");
          },
        ),
      );
    }

    // Add share icon (always present)
    icons.add(
      IconButton(
        icon: const Icon(Icons.share, color: Colors.black),
        onPressed: () {
          // Share functionality
          print("Shared item at index $index");
        },
      ),
    );

    return icons;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double avatarSize = size.height * 0.05;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header section for identity information
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Identity Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Created: ${widget.identityInfo['created']}'),
              Text('Modified: ${widget.identityInfo['modified']}'),
              Text('State: ${widget.identityInfo['state']}'),
            ],
          ),
        ),
        const Divider(), // Separator between header and list
        // Scrollable list for assets
        Expanded(
          child: ListView.builder(
            itemCount: widget.assets.length,
            itemBuilder: (context, index) {
              var asset = widget.assets[index]; // Access the asset data

              return GestureDetector(
                onTap: () => _shakeItem(index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: AnimatedBuilder(
                    animation: _shakeControllers[index],
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(_shakeControllers[index].value, 0),
                        child: child,
                      );
                    },
                    child: Card(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: _getTrailingIcons(index),
                        ),
                        title: Text(
                          asset['assetName'], // Display asset name
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
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
                            _unlocked[index] ? Icons.lock_open : Icons.lock,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
