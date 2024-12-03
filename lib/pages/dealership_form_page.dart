import 'package:flutter/material.dart';
import 'package:groupprojfinal/database/database_helper.dart';
import 'package:groupprojfinal/models/dealership.dart';

class DealershipFormPage extends StatefulWidget {
  @override
  _DealershipFormPageState createState() => _DealershipFormPageState();
}

class _DealershipFormPageState extends State<DealershipFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _streetAddressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _streetAddressController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  // Submit function for saving the dealership data to the database
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final newDealership = Dealership(
        name: _nameController.text,
        streetAddress: _streetAddressController.text,
        city: _cityController.text,
        postalCode: _postalCodeController.text,
      );

      // Insert the new dealership into the database
      final int result = await DatabaseHelper.instance.insertDealership(newDealership);

      if (result > 0) {
        // If successful, return to the previous page with success status
        Navigator.pop(context, true);
      } else {
        // If something goes wrong, show an error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add dealership.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Dealership')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dealership Name Field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Dealership Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              // Street Address Field
              TextFormField(
                controller: _streetAddressController,
                decoration: InputDecoration(labelText: 'Street Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a street address';
                  }
                  return null;
                },
              ),
              // City Field
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a city';
                  }
                  return null;
                },
              ),
              // Postal Code Field
              TextFormField(
                controller: _postalCodeController,
                decoration: InputDecoration(labelText: 'Postal Code'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a postal code';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






