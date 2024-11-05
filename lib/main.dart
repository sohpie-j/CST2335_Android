import 'package:flutter/material.dart';
import 'package:my_cst2335_labs/ToDoDatabase.dart';
import 'package:my_cst2335_labs/ToDoItemDao.dart';
import 'ToDoItem.dart';

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
  late BuildContext theContext;
  late TextEditingController _controller;
  late ToDoItemDao myDAO;

  List<ToDoItem> items = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    // Initialize the database and load items
    $FloorToDoDatabase.databaseBuilder('filenameOnYourDevice.db')
        .build()
        .then((database) async {
      myDAO = database.toDoItemDao;

      // Load existing items from the database
      items = await myDAO.getAllToDoItem();
      setState(() {}); // Refresh the UI after loading items
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      var input = _controller.text;
      if (input.isNotEmpty) {
        var todoItem = ToDoItem(ToDoItem.ID++, input);
        myDAO.insertItem(todoItem); // Save item to the database
        items.add(todoItem);        // Add item to the local list
        _controller.clear();         // Clear the text field after adding
      }
    });
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Item'),
          content: Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  myDAO.deleteToDoItem(items[index]); // Delete from the database
                  items.removeAt(index);               // Remove item from the local list
                });
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    theContext = context;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type something here",
                      labelText: "Put your first name here",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Spacing between TextField and Button
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: Text("Add ToDo"),
                ),
              ],
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? Center(child: Text("There are no items in the list"))
                : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("Item ${index + 1}: ${items[index].toString()}"),
                  onLongPress: () => _confirmDelete(index),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Add ToDo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
