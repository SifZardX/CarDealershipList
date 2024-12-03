import 'package:flutter/material.dart';
import 'package:groupprojfinal/database/database_helper.dart';
import 'package:groupprojfinal/models/dealership.dart';
import 'package:groupprojfinal/pages/dealership_form_page.dart';

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
  Future<void> _loadDealerships() async {
    final dealerships = await DatabaseHelper.instance.getDealerships();
    setState(() {
      _dealerships = dealerships;
    });
  }

  // Delete a dealership from the database
  Future<void> _deleteDealership(int id) async {
    await DatabaseHelper.instance.deleteDealership(id);
    _loadDealerships(); // Reload the list after deletion
  }

  // Navigate to the Add Dealership page
  Future<void> _navigateToAddDealership() async {
    final bool? dealershipAdded = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DealershipFormPage(), // Create a new dealership
      ),
    );

    if (dealershipAdded == true) {
      _loadDealerships(); // Reload the list after adding a dealership
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Dealerships'),
      ),
      body: ListView.builder(
        itemCount: _dealerships.length,
        itemBuilder: (context, index) {
          final dealership = _dealerships[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              title: Text(dealership.name),
              subtitle: Text(dealership.streetAddress),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _deleteDealership(dealership.id!),
              ),
              onTap: () async {
                final bool? dealershipAdded = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DealershipFormPage(dealership: dealership), // Pass dealership to edit
                  ),
                );

                if (dealershipAdded == true) {
                  _loadDealerships(); // Reload the list if a dealership was added or updated
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddDealership,
        child: const Icon(Icons.add),
        tooltip: 'Add Dealership',
      ),
    );
  }
}





