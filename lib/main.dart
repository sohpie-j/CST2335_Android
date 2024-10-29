import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
  List<String> words = [];

  // Initializing the controller
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  // Function to add items to the list
  void _addItem() {
    setState(() {
      words.add(_controller.text);
      _controller.clear(); // Clear the TextField after adding
    });
  }

  @override
  Widget build(BuildContext context) {
    theContext = context;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Week 4"),
      ),
      body: Column(
        children: [
          // Row with TextField and Add Button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                ElevatedButton(
                  onPressed: _addItem,
                  child: Text("Add item"),
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Enter",
                      border: OutlineInputBorder(),
                      labelText: "To do item",
                    ),
                  ),
                ),
                const SizedBox(width: 8), // Space between TextField and Button

              ],
            ),
          ),
          // Expanded ListView to show the list items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: words.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      words.removeAt(index);
                    });
                  },
                  child: ListTile(
                    title: Text(words[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
