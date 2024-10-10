import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List to hold the to-do items
  List<String> _todoItems = [];

  // Controller to handle TextField input
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to add an item to the list
  void _addToDoItem(String item) {
    setState(() {
      _todoItems.add(item); // Add item to list
      _controller.clear(); // Clear the TextField after adding
    });
  }

  // Function to show dialog to confirm deletion
  void _deleteToDoItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Item"),
          content: const Text("Are you sure you want to delete this item?"),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _todoItems.removeAt(index); // Delete the item
                });
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog without deleting
              },
              child: const Text("No"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Row for TextField and Add Button
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _addToDoItem(_controller.text); // Add item when 'Add' is pressed
                    }
                  },
                  child: const Text("Add"),
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Enter a task',
                    ),
                  ),
                ),

              ],
            ),
            const SizedBox(height: 20),
            // Display list of items or a message if the list is empty
            Expanded(
              child: _todoItems.isEmpty
                  ? const Center(
                child: Text('There are no items in the list'),
              ) : ListView.builder(
                itemCount: _todoItems.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () {
                      _deleteToDoItem(index); // Trigger delete on long press
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Item $index:'), // Display row number
                          Text(_todoItems[index]), // Display the to-do item
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
