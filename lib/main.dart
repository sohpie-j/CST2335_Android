import 'package:flutter/material.dart';
import 'package:my_cst2335_labs/to_do_item.dart';
import 'dart:async';

import 'package:my_cst2335_labs/to_do_item_dao.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final dao = database.toDoItemDao;
  runApp(ToDoApp(dao));
}

class ToDoApp extends StatelessWidget {
  final ToDoItemDao dao;

  ToDoApp(this.dao);

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

  ToDoHomePage({required this.dao});

  @override
  _ToDoHomePageState createState() => _ToDoHomePageState();
}

class _ToDoHomePageState extends State<ToDoHomePage> {
  final List<String> _items = [];
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadItemsFromDatabase();
  }

  Future<void> _loadItemsFromDatabase() async {
    final items = await widget.dao.findAllToDoItems();
    setState(() {
      _items.clear();
      _items.addAll(items.map((item) => item.content));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Flutter Demo Home Page'),
        ),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: _addItem,
                  child: Text('Add'),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter a to-do item',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: _items.isEmpty
                  ? Center(
                child: Text('There are no items in the list'),
              )
                  : ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () => _confirmDeleteItem(index),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Item $index: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(_items[index]),
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

  Future<void> _addItem() async {
    if (_textController.text.isNotEmpty) {
      final newItem = ToDoItem(content: _textController.text);
      await widget.dao.insertToDoItem(newItem);
      setState(() {
        _items.add(_textController.text);
        _textController.clear();
      });
    }
  }

  void _confirmDeleteItem(int index) {
    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Item'),
          content: Text('Do you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                _deleteItem(index);
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteItem(int index) async {
    final itemContent = _items[index];
    await widget.dao.deleteToDoItemByContent(itemContent);
    setState(() {
      _items.removeAt(index);
    });
  }
}

