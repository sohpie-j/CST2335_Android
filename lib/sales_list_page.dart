import 'package:flutter/material.dart';

class SalesListPage extends StatefulWidget {
  @override
  _SalesListPageState createState() => _SalesListPageState();
}

class _SalesListPageState extends State<SalesListPage> {
  final List<Map<String, String>> _sales = [];
  final TextEditingController _customerIdController = TextEditingController();
  final TextEditingController _carIdController = TextEditingController();
  final TextEditingController _dealershipIdController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  void _addSale() {
    if (_customerIdController.text.isNotEmpty &&
        _carIdController.text.isNotEmpty &&
        _dealershipIdController.text.isNotEmpty &&
        _dateController.text.isNotEmpty) {
      setState(() {
        _sales.add({
          'customerId': _customerIdController.text,
          'carId': _carIdController.text,
          'dealershipId': _dealershipIdController.text,
          'date': _dateController.text,
        });
      });
      _customerIdController.clear();
      _carIdController.clear();
      _dealershipIdController.clear();
      _dateController.clear();
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  void _deleteSale(int index) {
    setState(() {
      _sales.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _sales.length,
              itemBuilder: (context, index) {
                final sale = _sales[index];
                return ListTile(
                  title: Text(
                      'Customer ${sale['customerId']} - Car ${sale['carId']}'),
                  subtitle:
                  Text('${sale['dealershipId']} on ${sale['date']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteSale(index),
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
              title: Text('Add Sale'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _customerIdController,
                    decoration: InputDecoration(labelText: 'Customer ID'),
                  ),
                  TextField(
                    controller: _carIdController,
                    decoration: InputDecoration(labelText: 'Car ID'),
                  ),
                  TextField(
                    controller: _dealershipIdController,
                    decoration: InputDecoration(labelText: 'Dealership ID'),
                  ),
                  TextField(
                    controller: _dateController,
                    decoration: InputDecoration(labelText: 'Date'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: _addSale,
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
