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
    // Check if field_phone is a string, otherwise handle as a nested object
    String phoneNumber = '';

    if (jsonData['field_phone'] is String) {
      phoneNumber = jsonData['field_phone'];
    } else if (jsonData['field_phone'] is Map) {
      // Adjust based on the actual structure of the JSON
      phoneNumber = jsonData['field_phone']['value'] ?? 'No phone number';
    } else {
      phoneNumber = 'No phone number';
    }

    // // Check if assets is a string and split if necessary
    // String assets = '';

    // if (jsonData['field_access_assets'] is String) {
    //   assets = jsonData['field_access_assets'];
    // } else if (jsonData['field_access_assets'] is List) {
    //   // If it's already a list, join them into a comma-separated string
    //   assets = jsonData['field_access_assets'].join(', ');
    // }

    // // Split the assets string into a list of individual items
    // List<String> assetsList =
    //     assets.split(',').map((item) => item.trim()).toList();

    return {'phoneNumber': phoneNumber};
  }
}
