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
      debugShowCheckedModeBanner: false, //removed debug symbol on right up corner.
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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //int _counter = 0;
  // late TextEditingController _controller;  // call it somewhere else. late- constructor in inState, not null

  var isChecked = false;

  late TextEditingController _loginController;
  late TextEditingController _passwordController;

  // final TextEditingController _loginController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  String imageSource = 'images/question.png';  // Initial image

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

@override
  void initState() {

    super.initState();
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
  }
@override
  bool operator == (Object other) {
    // TODO: implement ==
    return super == other;
  }

  @override
  void dispose() {

    // _controller.dispose();
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

  //TOP-MOST ELEMENT IS Scaffold
    return Scaffold(
      drawer:
      Column(children: [
        Text("I am in a drawer"),
        Text("I am in a drawer"),
        Text("I am in a drawer"),
        Text("I am in a drawer"),
        Text("I am in a drawer"),
      ]),
      //drawer: Text("I am in a drawer"),

      bottomNavigationBar: BottomNavigationBar(
          onTap: ( whichItem) {    //double whichItem -- double can deleted
            if (whichItem == 0){

            } else if (whichItem ==1) {

            }
          },
          items: [
        BottomNavigationBarItem(icon: Icon(Icons.add_a_photo_outlined), label:"Camera"),
        BottomNavigationBarItem(icon: Icon(Icons.add_card), label: "Payment"),

      ]),
      appBar: AppBar(
        actions: [
         // Column(children:[
          OutlinedButton(onPressed: () {}, child: Text("Button 1")),
          OutlinedButton(onPressed: () {}, child: Text("Button 2")),
          OutlinedButton(onPressed: () {}, child: Text("Button 3")),
          OutlinedButton(onPressed: () {}, child: Text("Button 4")),
          OutlinedButton(onPressed: () {}, child: Text("Button 5")),
        //  ]) //makes column
        ], // arrary of Widgets
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
       title: Text("KyungA's Application"),
      ),
      body: Center(
        //child: Column( mainAxisAlignment: MainAxisAlignment.spaceAround,
        child: Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget> [
            ElevatedButton(child:Text("Button1"), onPressed:buttonClicked),
            ElevatedButton(child:Text("Button2"), onPressed:buttonClicked),
            ElevatedButton(child:Text("Button3"), onPressed:buttonClicked),
            ElevatedButton(child:Text("Button4"), onPressed:buttonClicked),
            ElevatedButton(child:Text("Button5"), onPressed:buttonClicked),
            ElevatedButton(child:Text("Button6"), onPressed:buttonClicked),

          ],
        ),
      ),
    );
  }

  void buttonClicked  () {
  }

}
