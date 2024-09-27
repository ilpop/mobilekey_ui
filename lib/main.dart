import 'dart:convert'; // For json parsing
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle; // To read assets
import 'package:url_launcher/url_launcher.dart'; // For launching URLs
import 'services/json_parser.dart'; // Import DataService

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MobileKey'),
        ),
        body: ScrollableListView(),
      ),
    );
  }
}

class ScrollableListView extends StatefulWidget {
  const ScrollableListView({super.key});

  @override
  _ScrollableListViewState createState() => _ScrollableListViewState();
}

class _ScrollableListViewState extends State<ScrollableListView> {
  List<dynamic> items = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // Load JSON data from assets
  Future<void> loadData() async {
    JsonParser jsonParser = JsonParser();
    List<dynamic> loadedItems =
        await jsonParser.loadJsonData('assets/data.json');
    setState(() {
      items = loadedItems;
    });
  }

  // Function to open the URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width for dynamic layout
    var screenWidth = MediaQuery.of(context).size.width;

    // Estimate the height of one item (e.g., 80 pixels)
    double itemHeight = 80.0;

    return items.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Center(
            // Center the list vertically
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                // Limit height to show 3 items at a time and center vertically
                height: itemHeight * 3, // 3 items visible at a time
                width: screenWidth > 600
                    ? 600
                    : screenWidth * 0.9, // Adaptive width
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
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                        child: ListTile(
                          leading: Image.asset(
                            items[index]['image'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Row(
                            // Display both text and "Reserve" button in a row
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                items[index]['text'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold, // Bold text
                                  fontSize: 18,
                                ),
                              ),
                              if (items[index]['link'] !=
                                  null) // Show "Reserve" if link is present
                                TextButton(
                                  onPressed: () {
                                    _launchURL(items[index]['link']);
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
                      ),
                    );
                  },
                ),
              ),
            ),
          );
  }
}
