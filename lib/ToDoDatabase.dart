
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'ToDoItemDao.dart';
import 'ToDoItem.dart';

part 'ToDoDatabase.g.dart';

@Database(version: 1, entities: [ToDoItem])
abstract class ToDoDatabase extends FloorDatabase
{
  ToDoItemDao get toDoItemDao; //no (), it's not a function
}