import 'package:flutter/material.dart';
import 'package:groupprojfinal/database/database_helper.dart';
import 'package:groupprojfinal/models/dealership.dart';

class DealershipFormPage extends StatefulWidget {
  final Dealership? dealership;

  DealershipFormPage({this.dealership});

  @override
  _DealershipFormPageState createState() => _DealershipFormPageState();
}

class _DealershipFormPageState extends State<DealershipFormPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();  // Add city controller
  final postalCodeController = TextEditingController();  // Add postal code controller

  @override
  void initState() {
    super.initState();
    if (widget.dealership != null) {
      nameController.text = widget.dealership!.name;
      addressController.text = widget.dealership!.streetAddress;
      cityController.text = widget.dealership!.city;  // Set city
      postalCodeController.text = widget.dealership!.postalCode;  // Set postal code
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
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Dealership Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter dealership name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Street Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter street address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: cityController,  // Add city input
                decoration: InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter city';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: postalCodeController,  // Add postal code input
                decoration: InputDecoration(labelText: 'Postal Code'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter postal code';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final dealership = Dealership(
                      name: nameController.text,
                      streetAddress: addressController.text,
                      city: cityController.text,  // Include city
                      postalCode: postalCodeController.text,  // Include postal code
                    );

                    // Insert dealership into the database
                    await DatabaseHelper.instance.insertDealership(dealership);
                    Navigator.pop(context, true);  // Return true on successful insert
                  } else {
                    Navigator.pop(context, false); // Return false on validation failure
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





