import 'dart:convert'; // For json parsing
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle; // To read assets

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('MobileKey'),
        ),
        body: ScrollableListView(),
      ),
    );
  }
}

class ScrollableListView extends StatefulWidget {
  @override
  _ScrollableListViewState createState() => _ScrollableListViewState();
}

class _ScrollableListViewState extends State<ScrollableListView> {
  List<dynamic> items = [];

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  // Load JSON data from assets
  Future<void> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/data.json');
    setState(() {
      items = json.decode(jsonString);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width for dynamic layout
    var screenWidth = MediaQuery.of(context).size.width;

    return items.isEmpty
        ? Center(child: CircularProgressIndicator())
        : Center( // Center the whole ListView in the middle of the screen
            child: Container(
              width: screenWidth > 600 ? 600 : screenWidth * 0.9, // Adaptive width
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // Black border
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                      ),
                      child: ListTile(
                        leading: Image.asset(
                          items[index]['image'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Center( // Center the text
                          child: Text(
                            items[index]['text'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold, // Bold text
                              fontSize: 18,
                            ),
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
