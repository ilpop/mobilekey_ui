import 'package:http/http.dart' as http;
import 'dart:convert';

class RoomTypeService {
  Future<List<String>> fetchRoomTypes() async {
    List<String> allRoomTypes = [];
    String? nextUrl =
        'https://respa.api.hel.fi/respa/v1/type/?format=json'; // Start from the first page

    // Loop through all pages
    while (nextUrl != null) {
      final response = await http.get(Uri.parse(nextUrl));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var types = data['results'];

        // Add the current page's room types to the list (in English)
        allRoomTypes.addAll(
          types
              .map<String>((type) =>
                  type['name']?['en']?.toString() ?? 'Unnamed room type')
              .toList(),
        );

        // Update the nextUrl to the next page, if it exists
        nextUrl = data['next'];
      } else {
        throw Exception('Failed to load room types');
      }
    }

    return allRoomTypes;
  }
}
