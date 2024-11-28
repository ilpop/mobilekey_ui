import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../services/graphql_client.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: FutureBuilder<QueryResult>(
        future: GraphQLConfig.fetchData(), // Call the GraphQL service
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            // Extract the data from the query result
            final assets = snapshot.data!.data?['assets'];

            // Display the data
            return ListView.builder(
              itemCount: assets.length,
              itemBuilder: (context, index) {
                var asset = assets[index];
                return ListTile(
                  title: Text(asset['assetName']),
                  subtitle: Text(asset['provider']),
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
