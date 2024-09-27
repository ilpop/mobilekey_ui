import 'package:flutter/material.dart';
import 'package:mobilekey_ui/services/json_parser.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String phoneNumber = '';
  List<String> assets = [];

  @override
  void initState() {
    super.initState();
    loadDataFromAssets();
  }

  // Use the JsonParser class to load data from the assets
  Future<void> loadDataFromAssets() async {
    JsonParser jsonParser = JsonParser();
    String assetPath = 'assets/data.json';

    try {
      List<dynamic> jsonData = await jsonParser.loadJsonFromAssets(assetPath);

      // Assuming we want to process the first item in the array
      if (jsonData.isNotEmpty) {
        Map<String, dynamic> extractedData =
            jsonParser.extractPhoneNumberAndAssets(jsonData[0]);

        setState(() {
          phoneNumber = extractedData['phoneNumber'];
          assets = extractedData['assets'];
        });
      }
    } catch (e) {
      // Handle errors (e.g., show an error message)
      print('Error loading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    double itemHeight = 80.0;

    return phoneNumber.isEmpty && assets.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: itemHeight * 3,
                width: screenWidth > 600 ? 600 : screenWidth * 0.9,
                child: ListView.builder(
                  itemCount: assets.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(assets[index]),
                        subtitle: Text(phoneNumber),
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
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
