

import 'package:floor/floor.dart';

import 'ToDoItem.dart';

@dao //this understands insert, delete, update, query
abstract class ToDoItemDAO {

  @Query('SELECT * from ToDoItem')
  Future<List<ToDoItem>> getAllItems(); //asynchronous return 0 or more matches

  @insert //generate the insertion code for itm in the database
  Future<void> insertItem(ToDoItem itm);

  @delete  //generate the delete code for itm in the database
  Future<void> deleteThisItem(ToDoItem itm);

  @update //generate the UPDATE SQL code
  Future<void> updateItem(ToDoItem itm);
}