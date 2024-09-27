import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class JsonParser {
  // Load JSON data from the assets folder
  Future<List<dynamic>> loadJsonFromAssets(String assetPath) async {
    String jsonString = await rootBundle.loadString(assetPath);
    return json.decode(jsonString); // Now returns a List<dynamic>
  }

  // Extract the phone number and assets from each item in the JSON data
  Map<String, dynamic> extractPhoneNumberAndAssets(
      Map<String, dynamic> jsonData) {
    String phoneNumber = jsonData['field_phone'] ?? 'No phone number';
    String assets = jsonData['field_access_assets'] ?? '';

    // Split the assets string into a list of individual items
    List<String> assetsList =
        assets.split(',').map((item) => item.trim()).toList();

    return {
      'phoneNumber': phoneNumber,
      'assets': assetsList,
    };
  }
}
