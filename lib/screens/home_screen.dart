import 'package:flutter/material.dart';
import 'package:groupprojfinal/pages/car_dealership_list_page.dart'; // Correct import

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
            // Navigating to CarDealershipListPage
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


