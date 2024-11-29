import 'package:flutter/material.dart';

class DealershipListPage extends StatefulWidget {
  @override
  _DealershipListPageState createState() => _DealershipListPageState();
}

class _DealershipListPageState extends State<DealershipListPage> {
  final List<Map<String, String>> _dealerships = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  void _addDealership() {
    if (_nameController.text.isNotEmpty &&
        _addressController.text.isNotEmpty &&
        _cityController.text.isNotEmpty &&
        _postalCodeController.text.isNotEmpty) {
      setState(() {
        _dealerships.add({
          'name': _nameController.text,
          'address': _addressController.text,
          'city': _cityController.text,
          'postalCode': _postalCodeController.text,
        });
      });
      _nameController.clear();
      _addressController.clear();
      _cityController.clear();
      _postalCodeController.clear();
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  void _deleteDealership(int index) {
    setState(() {
      _dealerships.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dealership List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _dealerships.length,
              itemBuilder: (context, index) {
                final dealership = _dealerships[index];
                return ListTile(
                  title: Text(dealership['name']!),
                  subtitle: Text('${dealership['address']} - ${dealership['city']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteDealership(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Add Dealership'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: _addressController,
                    decoration: InputDecoration(labelText: 'Address'),
                  ),
                  TextField(
                    controller: _cityController,
                    decoration: InputDecoration(labelText: 'City'),
                  ),
                  TextField(
                    controller: _postalCodeController,
                    decoration: InputDecoration(labelText: 'Postal Code'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: _addDealership,
                  child: Text('Add'),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
