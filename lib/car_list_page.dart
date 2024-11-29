import 'package:flutter/material.dart';

class CarListPage extends StatefulWidget {
  @override
  _CarListPageState createState() => _CarListPageState();
}

class _CarListPageState extends State<CarListPage> {
  final List<Map<String, String>> _cars = [];
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _passengersController = TextEditingController();
  final TextEditingController _fuelCapacityController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  // 자동차 추가
  void _addCar() {
    if (_brandController.text.isNotEmpty &&
        _modelController.text.isNotEmpty &&
        _passengersController.text.isNotEmpty &&
        _fuelCapacityController.text.isNotEmpty &&
        _imageUrlController.text.isNotEmpty) {
      setState(() {
        _cars.add({
          'brand': _brandController.text,
          'model': _modelController.text,
          'passengers': _passengersController.text,
          'fuelCapacity': _fuelCapacityController.text,
          'imageUrl': _imageUrlController.text,
        });
      });
      _clearFields();
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  // 자동차 삭제
  void _deleteCar(int index) {
    setState(() {
      _cars.removeAt(index);
    });
  }

  // 필드 초기화
  void _clearFields() {
    _brandController.clear();
    _modelController.clear();
    _passengersController.clear();
    _fuelCapacityController.clear();
    _imageUrlController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car List'),
      ),
      body: Column(
        children: [
          _cars.isEmpty
              ? Expanded(
            child: Center(
              child: Text(
                'No cars available. Add a car using the "+" button.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          )
              : Expanded(
            child: ListView.builder(
              itemCount: _cars.length,
              itemBuilder: (context, index) {
                final car = _cars[index];
                return ListTile(
                  leading: car['imageUrl'] != null
                      ? Image.network(
                    car['imageUrl']!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error);
                    },
                  )
                      : Icon(Icons.directions_car),
                  title: Text('${car['brand']} ${car['model']}'),
                  subtitle: Text(
                      '${car['passengers']} passengers, ${car['fuelCapacity']}L'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteCar(index),
                  ),
                  onTap: () => _showCarDetails(index), // 항목 선택 시 세부 정보 표시
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCarDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  // 새 자동차 추가 다이얼로그
  void _showAddCarDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Car'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _brandController,
                decoration: InputDecoration(labelText: 'Brand'),
              ),
              TextField(
                controller: _modelController,
                decoration: InputDecoration(labelText: 'Model'),
              ),
              TextField(
                controller: _passengersController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Passengers'),
              ),
              TextField(
                controller: _fuelCapacityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Fuel Capacity (L)'),
              ),
              TextField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: _addCar,
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  // 자동차 세부 정보 표시 (선택 시 호출)
  void _showCarDetails(int index) {
    final car = _cars[index];
    _brandController.text = car['brand']!;
    _modelController.text = car['model']!;
    _passengersController.text = car['passengers']!;
    _fuelCapacityController.text = car['fuelCapacity']!;
    _imageUrlController.text = car['imageUrl']!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Car Details'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _brandController,
                decoration: InputDecoration(labelText: 'Brand'),
              ),
              TextField(
                controller: _modelController,
                decoration: InputDecoration(labelText: 'Model'),
              ),
              TextField(
                controller: _passengersController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Passengers'),
              ),
              TextField(
                controller: _fuelCapacityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Fuel Capacity (L)'),
              ),
              TextField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => _updateCar(index),
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  // 자동차 업데이트
  void _updateCar(int index) {
    setState(() {
      _cars[index] = {
        'brand': _brandController.text,
        'model': _modelController.text,
        'passengers': _passengersController.text,
        'fuelCapacity': _fuelCapacityController.text,
        'imageUrl': _imageUrlController.text,
      };
    });
    _clearFields();
    Navigator.of(context).pop();
  }
}
