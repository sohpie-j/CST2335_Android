import 'package:flutter/material.dart';
import 'package:my_cst2335_labs/to_do_item.dart';
import 'dart:async';
import 'package:my_cst2335_labs/to_do_item_dao.dart';
import 'databse.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final dao = database.toDoItemDao;
  runApp(ToDoApp(dao));
}

class ToDoApp extends StatelessWidget {
  final ToDoItemDao dao;

  const ToDoApp(this.dao);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Home Page',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: ToDoHomePage(dao: dao),
    );
  }
}

class ToDoHomePage extends StatefulWidget {
  final ToDoItemDao dao;

  const ToDoHomePage({required this.dao});

  @override
  _ToDoHomePageState createState() => _ToDoHomePageState();
}

class _ToDoHomePageState extends State<ToDoHomePage> {
  final List<ToDoItem> _items = [];
  final TextEditingController _textController = TextEditingController();
  ToDoItem? selectedItem;

  @override
  void initState() {
    super.initState();
    _loadItemsFromDatabase();
  }

  Future<void> _loadItemsFromDatabase() async {
    final items = await widget.dao.findAllToDoItems();
    setState(() {
      _items.clear();
      _items.addAll(items);
    });
  }

  Widget reactiveLayout() {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    // Master-Detail layout for tablet and landscape mode with width > 720
    if ((width > height) && (width > 720)) {
      return Row(
        children: [
          Expanded(
            flex: 1,
            child: toDoList(),
          ),
          Expanded(
            flex: 2,
            child: detailsPage(),
          ),
        ],
      );
    } else {
      // Single view layout for phone
      return selectedItem == null ? toDoList() : detailsPage();
    }
  }

  Widget toDoList() {
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedItem = _items[index];
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Item ${_items[index].id}: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(_items[index].content),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget detailsPage() {
    if (selectedItem == null) {
      return const Center(child: Text('No item selected'));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Item ID: ${selectedItem!.id}', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          Text('Content: ${selectedItem!.content}', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              _deleteItem(selectedItem!);
            },
            child: const Text('Delete Item'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: const Center(
          child: Text('Flutter Demo Home Page'),
        ),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: reactiveLayout(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _addItem() async {
    if (_textController.text.isNotEmpty) {
      final newItem = ToDoItem(content: _textController.text);
      await widget.dao.insertToDoItem(newItem);
      _textController.clear();
      _loadItemsFromDatabase();
    }
  }

  Future<void> _deleteItem(ToDoItem item) async {
    await widget.dao.deleteToDoItemByContent(item.content);
    setState(() {
      _items.remove(item);
      selectedItem = null;
    });
  }

  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add To-Do Item'),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(hintText: 'Enter to-do item'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addItem();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
