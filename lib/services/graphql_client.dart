import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GraphQLConfig {
  static final HttpLink httpLink = HttpLink(
    dotenv.env['GRAPHQL_API_URL'] ?? 'https://default-url.com/graphql',
    defaultHeaders: {
      'x-api-key': dotenv.env['API_KEY'] ?? '', // Use API_KEY from .env
      'Authorization':
          dotenv.env['BEARER_TOKEN'] ?? '', // Use BEARER_TOKEN from .env
    },
  );

  static ValueNotifier<GraphQLClient> initClient() {
    return ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: InMemoryStore()),
      ),
    );
  }

  // Function to fetch data from the GraphQL API
  static Future<QueryResult> fetchData() async {
    const String query = """
      query IdentityAndAssetsQuery {
        identity {
          created
          identityId
          modified
          state
        }
        assets {
          id
          allowed
          assetId
          assetName
          provider
        }
      }
    """;

    final client = initClient().value;
    final result = await client.query(
      QueryOptions(
        document: gql(query),
      ),
    );

    return result;
  }
}
