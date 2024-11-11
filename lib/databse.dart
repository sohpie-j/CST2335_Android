import 'dart:async';
import 'package:floor/floor.dart';
import 'package:my_cst2335_labs/to_do_item.dart';
import 'package:my_cst2335_labs/to_do_item_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [ToDoItem])
abstract class AppDatabase extends FloorDatabase {
  ToDoItemDao get toDoItemDao;
}
