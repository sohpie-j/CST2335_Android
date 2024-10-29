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

  late TextEditingController _controller; //late - Constructor in initState()


  //called first:
  @override //same as in java
  void initState()  {
    super.initState(); //call the parent initState()
    _controller = TextEditingController(); //our late constructor

  }


  @override
  void dispose()
  {
    super.dispose();
    _controller.dispose();    // clean up memory
  }


  @override
  Widget build(BuildContext context) {
    theContext = context;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Week 4"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(controller: _controller,
                decoration: InputDecoration(
                    hintText:"Type your login name",
                    border: OutlineInputBorder(),
                    labelText: "Login"
                ))
          ],
        ),
      ),
    );
  }



}
