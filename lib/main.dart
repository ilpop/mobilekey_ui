import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'services/graphql_client.dart'; // Import the GraphQLConfig class

void main() async {
  // Load the .env file before app initialization
  await dotenv.load();

  print(dotenv.env['GRAPHQL_API_URL']);
  print(dotenv.env['API_KEY']);
  print(dotenv.env['BEARER_TOKEN']);
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();

  final client = GraphQLConfig.initClient().value;

  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  final GraphQLClient client;

  const MyApp({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter GraphQL Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(client: client),
    );
  }
}

class HomePage extends StatelessWidget {
  final GraphQLClient client;

  const HomePage({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GraphQL Data')),
      body: FutureBuilder<QueryResult>(
        future: GraphQLConfig.fetchData(), // Fetch data from API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            final identity = snapshot.data!.data?['identity'];
            final assets = snapshot.data!.data?['assets'];

            return ListView.builder(
              itemCount: assets.length,
              itemBuilder: (context, index) {
                var asset = assets[index];
                // Print asset details
                print('Asset ID: ${asset['id']}');
                print('Allowed: ${asset['allowed']}');
                print('Asset ID (assetId): ${asset['assetId']}');
                print('Asset Name: ${asset['assetName']}');
                print('Provider: ${asset['provider']}');

                return ListTile(
                  title: Text(asset['assetName']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${asset['id']}'),
                      Text('Allowed: ${asset['allowed']}'),
                      Text('Asset ID: ${asset['assetId']}'),
                      Text('Provider: ${asset['provider']}'),
                    ],
                  ),
                );
              },
            );
          }

          return const Center(child: Text('No Data Available'));
        },
      ),
    );
  }
}
