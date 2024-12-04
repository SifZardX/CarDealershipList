import 'package:flutter/material.dart';
import 'package:groupprojfinal/database/database_helper.dart';
import 'package:groupprojfinal/models/dealership.dart';

class DealershipFormPage extends StatefulWidget {
  final Dealership? dealership; // Pass dealership for editing if available

  // Constructor to allow either creating or editing a dealership
  DealershipFormPage({this.dealership});

  @override
  _DealershipFormPageState createState() => _DealershipFormPageState();
}

class _DealershipFormPageState extends State<DealershipFormPage> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late String _streetAddress;
  late String _city;
  late String _postalCode;

  @override
  void initState() {
    super.initState();

    // Initialize fields with the passed dealership data (if editing)
    if (widget.dealership != null) {
      _name = widget.dealership!.name;
      _streetAddress = widget.dealership!.streetAddress;
      _city = widget.dealership!.city;
      _postalCode = widget.dealership!.postalCode;
    } else {
      _name = '';
      _streetAddress = '';
      _city = '';
      _postalCode = '';
    }
  }

  // Submit the form (either insert or update)
  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final dealership = Dealership(
        id: widget.dealership?.id, // If editing, pass the existing ID
        name: _name,
        streetAddress: _streetAddress,
        city: _city,
        postalCode: _postalCode,
      );

      // Insert or update the dealership
      if (widget.dealership == null) {
        await DatabaseHelper.instance.insertDealership(dealership);
      } else {
        await DatabaseHelper.instance.updateDealership(dealership);
      }

      Navigator.pop(context, true); // Return to the dealership list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dealership == null ? 'Add Dealership' : 'Edit Dealership'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Dealership Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the dealership name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: _streetAddress,
                decoration: const InputDecoration(labelText: 'Street Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the street address';
                  }
                  return null;
                },
                onSaved: (value) => _streetAddress = value!,
              ),
              TextFormField(
                initialValue: _city,
                decoration: const InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the city';
                  }
                  return null;
                },
                onSaved: (value) => _city = value!,
              ),
              TextFormField(
                initialValue: _postalCode,
                decoration: const InputDecoration(labelText: 'Postal Code'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the postal code';
                  }
                  return null;
                },
                onSaved: (value) => _postalCode = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.dealership == null ? 'Add Dealership' : 'Update Dealership'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

