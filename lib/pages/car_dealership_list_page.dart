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

  // Show the Snackbar
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  // Delete a dealership from the database with a confirmation AlertDialog
  Future<void> _deleteDealership(int id, String name) async {
    final bool? confirmDelete = await _showDeleteConfirmationDialog(name);
    if (confirmDelete == true) {
      await DatabaseHelper.instance.deleteDealership(id);
      _loadDealerships(); // Reload the list after deletion
      _showSnackbar('Dealership deleted successfully');
    }
  }

  // Show the help dialog with instructions
  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Instructions'),
          content: const Text(
            'This is the list of car dealerships. You can add, edit, or delete dealerships.\n\n'
                '1. Use the "Add" button to add a dealership.\n'
                '2. Tap on a dealership to edit its details.\n'
                '3. Swipe left or press the delete icon to remove a dealership.',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();  // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // Show a confirmation dialog for deleting a dealership
  Future<bool?> _showDeleteConfirmationDialog(String name) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete the dealership "$name"?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),  // No
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),  // Yes
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
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
      _showSnackbar('Dealership added successfully');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Dealerships'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: _showHelpDialog,  // Show help dialog when pressed
          ),
        ],
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
                onPressed: () => _deleteDealership(dealership.id!, dealership.name),
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







