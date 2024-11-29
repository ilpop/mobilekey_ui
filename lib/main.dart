import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'services/graphql_client.dart';
import 'pages/login_page.dart';

void main() async {
  // Load the .env file before app initialization
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();

  final client = GraphQLConfig.initClient().value;

  runApp(MyApp(client: client));
}

class MyApp extends StatefulWidget {
  final GraphQLClient client;

  const MyApp({super.key, required this.client});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Set the primary color to black and text to white
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black, // Black background for AppBar
          foregroundColor: Colors.white, // White text for AppBar
          elevation: 1.0, // Little shadow
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor:
              Colors.black, // Black background for BottomNavigationBar
          selectedItemColor: Colors.white, // White selected icon/text
          unselectedItemColor: Colors.grey, // Grey unselected icon/text
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black), // Black body text
          bodyMedium:
              TextStyle(color: Colors.black), // Black body text (smaller)
          titleLarge: TextStyle(
            color: Colors.white, // White AppBar title text
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // White icons
        ),
      ),
      home: const LoginPage(),
    );
  }
}
