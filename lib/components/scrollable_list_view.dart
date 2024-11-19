// ignore_for_file: prefer_const_constructors

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

class _ScrollableListViewState extends State<ScrollableListView>
    with TickerProviderStateMixin {
  List<bool> _favorites = [];
  List<bool> _unlocked = [];
  List<AnimationController> _shakeControllers = [];

  @override
  void initState() {
    super.initState();
    _initializeStates();

    for (int i = 0; i < widget.assets.length; i++) {
      _shakeControllers.add(
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 300),
        ),
      );
    }
  }

  Future<void> _initializeStates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteItems = prefs.getStringList('favorites');

    setState(() {
      _favorites = widget.assets
          .map((asset) => favoriteItems?.contains(asset) ?? false)
          .toList();

      _unlocked = List<bool>.filled(widget.assets.length, false);
    });
  }

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

  void _toggleFavorite(int index) {
    setState(() {
      _favorites[index] = !_favorites[index];
    });
    _saveFavorites();
  }

  void _toggleLock(int index) {
    setState(() {
      _unlocked[index] = !_unlocked[index];
    });
  }

  void _shakeItem(int index) {
    final shakeAnimation =
        Tween<double>(begin: 0.0, end: 10.0).animate(CurvedAnimation(
      parent: _shakeControllers[index],
      curve: Curves.elasticInOut,
    ));

    _shakeControllers[index].forward(from: 0.0);
    _shakeControllers[index].addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _shakeControllers[index].reset();
      }
    });

    _toggleLock(index);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double itemHeight = size.height * 0.1;
    final double avatarSize = size.height * 0.05;
    final double fontSize = size.width * 0.04;

    return Center(
      child: ListView.builder(
        itemCount: widget.assets.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _shakeItem(index);
            },
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
                    contentPadding: EdgeInsets.symmetric(
                      vertical: itemHeight * 0.1,
                      horizontal: itemHeight * 0.2,
                    ),
                    // Modify this to show either the Bitcoin, Money, or Share icon
                    trailing: index % 4 == 3
                        ? const Icon(
                            Icons.payment,
                            color: Colors
                                .black, // Money icon for every fourth item
                          )
                        : (index % 3 == 2
                            ? Image.asset(
                                'assets/images/bitcoin-black-icon.png',

                                // Bitcoin icon for every third item
                                width: 24,
                                height: 24,
                              )
                            : IconButton(
                                // ignore: prefer_const_constructors
                                // ignore: prefer_const_constructors
                                icon: Icon(
                                  Icons.share,
                                  color: Colors
                                      .black, // Share icon for all other items
                                ),
                                onPressed: () {
                                  // Share functionality goes here
                                },
                              )),
                    title: Text(
                      widget.assets[index],
                      style: TextStyle(
                        fontSize: fontSize,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      widget.phoneNumber,
                      style: TextStyle(
                        fontSize: fontSize * 0.8,
                        color: Colors.black,
                      ),
                    ),
                    leading: CircleAvatar(
                      radius: avatarSize,
                      backgroundColor: Colors.black,
                      child: Icon(
                        _unlocked[index] ? Icons.lock_open : Icons.lock,
                        color: Colors.white,
                        size: avatarSize * 0.8,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _shakeControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
