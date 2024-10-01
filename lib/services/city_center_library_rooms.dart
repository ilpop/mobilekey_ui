import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http; // For making HTTP requests
import 'package:flutter/material.dart'; // For building the UI

class CityCenterLibraryRooms extends StatefulWidget {
  @override
  _CityCenterLibraryRoomsState createState() => _CityCenterLibraryRoomsState();
}

class _CityCenterLibraryRoomsState extends State<CityCenterLibraryRooms> {
  List rooms = []; // To store room data
  bool isLoading = true; // Loading state

  // Function to fetch rooms from City Center Library (assuming tprek:12345 is the correct unit ID)
  Future<void> fetchRooms() async {
    final url = Uri.parse(
        'https://respa.api.hel.fi/respa/v1/resource/?unit=tprek:51342&type=meeting_room');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        rooms = data['results']; // Assuming 'results' contains the room list
        isLoading = false; // Stop loading when data is fetched
      });
    } else {
      setState(() {
        isLoading = false; // Stop loading if request fails
      });
      throw Exception('Failed to load rooms');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRooms(); // Fetch rooms on widget load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('City Center Library Rooms'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : rooms.isEmpty
              ? Center(child: Text('No rooms found.'))
              : ListView.builder(
                  itemCount: rooms.length,
                  itemBuilder: (context, index) {
                    final room = rooms[index];
                    return ListTile(
                      title: Text(room['name'] ?? 'Unnamed Room'),
                      subtitle:
                          Text('Capacity: ${room['people_capacity'] ?? 'N/A'}'),
                      onTap: () {
                        // You can add functionality here when tapping on a room
                      },
                    );
                  },
                ),
    );
  }
}
