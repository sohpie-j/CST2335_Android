

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;


import 'ToDoItem.dart';
import 'ToDoItemDAO.dart';
import 'ToDoItemDao.dart';

part 'ToDoDatabase.g.dart';

@Database(version:1, entities: [ToDoItem])
abstract class ToDoDatabase extends FloorDatabase {
  ToDoItemDAO get toDoItemDAO;  //no () here, it's not a function
}