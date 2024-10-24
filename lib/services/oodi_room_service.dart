import 'package:http/http.dart' as http;
import 'dart:convert';

class OodiRoomService {
  final String oodiUnitId = 'tprek:51342'; // Oodi's unit ID

  // Fetch all rooms (resources) from Oodi
  Future<List<String>> fetchOodiRooms() async {
    List<String> oodiRooms = [];
    String? nextUrl =
        'https://api.hel.fi/respa/v1/resource/?unit=$oodiUnitId&format=json';

    // Loop through all pages
    while (nextUrl != null) {
      final response = await http.get(Uri.parse(nextUrl));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var resources = data['results'];

        // Add the current page's rooms (resources) to the list (in English)
        oodiRooms.addAll(
          resources
              .map<String>((resource) =>
                  resource['name']?['en']?.toString() ?? 'Unnamed Room')
              .toList(),
        );

        // Update the nextUrl to the next page, if it exists
        nextUrl = data['next'];
      } else {
        throw Exception('Failed to load rooms for Oodi');
      }
    }

    return oodiRooms;
  }
}
