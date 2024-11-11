import 'package:flutter/material.dart';
import 'package:my_cst2335_labs/ToDoItem.dart';

import 'ToDoDatabase.dart';
import 'ToDoItemDAO.dart';
import 'ToDoItemDao.dart';

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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
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
  int _counter = 0;

  late TextEditingController _controller; //late - Constructor in initState()
  late ToDoItemDAO myDAO; //initialized in initState()

  ToDoItem? selectedItem  = null;

  //add items from the database first:
  List<ToDoItem> items = [];

  var isChecked = false;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }



  @override //same as in java
  void initState() {
    super.initState(); //call the parent initState()
    _controller = TextEditingController(); //our late constructor
    //var database = await
    //open the database:
    $FloorToDoDatabase.databaseBuilder('filenameOnYourDevice.db').build()
        .then((database) async {

      myDAO = database.toDoItemDAO;
      //get Items from database:
      var it = await myDAO.getAllItems();

      setState(()  {
        items = it; //Future<> , asnynchronous
      });

    } ) ;
  }


  @override
  void dispose()
  {
    super.dispose();
    _controller.dispose();    // clean up memory
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: reactiveLayout(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget  reactiveLayout() {
    var size = MediaQuery
        .of(context)
        .size;
    var height = size.height;
    var width = size.width;

    if ((width > height) && (width > 720)) //landscape
        {
      return Row(children: [
        Expanded(flex: 1 , child:ToDoList()),
        Expanded(flex: 2, child:DetailsPage())
      ]);
    }
    else //portrait mode
        {
      if(selectedItem == null)
        return ToDoList();
      else{ //something is selected
        return DetailsPage();
      }
    }
  }

  Widget DetailsPage() {
    TextStyle st = TextStyle(fontSize: 40.0);

    return Column(children:[

      if(selectedItem == null)
        Text("Please select something from the list", style:st)
      else
        Text("You selected:" + selectedItem!.item, style:st) //! means non-null assertion
      ,
      ElevatedButton(child:Text("Ok"), onPressed: () {
        //update GUI:
        setState(() {
          selectedItem = null; //clear the selection
        });


      })

    ]);

  }

  Widget ToDoList(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(children: [
            Flexible(child:
            TextField(controller: _controller,
              decoration: InputDecoration(
                hintText: "Type something here",
                labelText: "Put your first name here",
                border: OutlineInputBorder(),
              ),
            )),

            ElevatedButton(onPressed: () {
              //what was typed is:
              var input = _controller.value.text;
              //generate UNIQUE ids
              var todoItem = ToDoItem(ToDoItem.ID++, input);
              myDAO.insertItem(todoItem);

              setState(() { //redraw the GUI

                items.add(todoItem); //add the item to the LIST

                _controller.text = ""; //reset the textField
              });
            }, //Lambda, or anonymous function
              child: Text("Add ToDO"),)
          ],),
          Flexible(child:
          ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, rowNum) {
                return
                  GestureDetector(
                      onTap:() {
                        setState(() {//redraw the GUI:
                          selectedItem = items[rowNum];
                        });

                      },
                      child:
                      Text("Item $rowNum = ${items[rowNum].item }",
                        style: TextStyle(fontSize: 30.0),));
              }))
        ],
      ),
    );
  }//end of reactiveLayout()

  //this runs when you click the button
  void buttonClicked   ( ){

  }


}
