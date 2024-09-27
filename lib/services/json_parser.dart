import 'package:flutter/material.dart';
import 'dart:convert'; // For json parsing
import 'package:flutter/services.dart' show rootBundle; // To read assets

class JsonParser {
  // Function to load and parse JSON data from the given asset path
  Future<List<dynamic>> loadJsonData(String assetPath) async {
    String jsonString = await rootBundle.loadString(assetPath);
    return json.decode(jsonString);
  }
}
