import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'pages/car_dealership_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Dealership App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Localization setup
      supportedLocales: [
        Locale('en', 'US'), // English (US)
        Locale('es', 'ES'), // Spanish
        Locale('fr', 'FR'), // French
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate, // For material components
        GlobalWidgetsLocalizations.delegate, // For widgets like buttons, etc.
      ],
      locale: Locale('en', 'US'), // Default locale is set to English (US)
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Dealership'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CarDealershipListPage()),
            );
          },
          child: Text('Go to Dealership List'),
        ),
      ),
    );
  }
}