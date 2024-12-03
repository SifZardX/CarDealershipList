import 'package:flutter/material.dart';
import 'package:groupprojfinal/database/database_helper.dart';
import 'package:groupprojfinal/models/dealership.dart';
import 'dealership_form_page.dart';

class CarDealershipListPage extends StatefulWidget {
  @override
  _CarDealershipListPageState createState() => _CarDealershipListPageState();
}

class _CarDealershipListPageState extends State<CarDealershipListPage> {
  List<Dealership> _dealerships = [];

  @override
  void initState() {
    super.initState();
    _loadDealerships();
  }

  // Load dealerships from the database
  void _loadDealerships() async {
    final dealerships = await DatabaseHelper.instance.getDealerships();
    if (mounted) {
      setState(() {
        _dealerships = dealerships;
      });
    }
  }

  // Navigate to Dealership Form Page to add a new dealership
  Future<void> _navigateToAddDealership() async {
    final bool? dealershipAdded = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DealershipFormPage()),
    );

    if (dealershipAdded == true) {
      _loadDealerships(); // Reload the list if a dealership was added
    }
  }

  // Delete a dealership from the list
  _deleteDealership(int id) async {
    await DatabaseHelper.instance.deleteDealership(id);
    _loadDealerships(); // Refresh the list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Car Dealerships')),
      body: ListView.builder(
        itemCount: _dealerships.length,
        itemBuilder: (context, index) {
          final dealership = _dealerships[index];
          return ListTile(
            title: Text(dealership.name),
            subtitle: Text(dealership.streetAddress),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteDealership(dealership.id!),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddDealership,
        child: Icon(Icons.add),
      ),
    );
  }
}













