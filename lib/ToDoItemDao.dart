
import 'package:floor/floor.dart';
import 'package:my_cst2335_labs/ToDoItem.dart';

@dao
abstract class ToDoItemDao {

  //return items from the database
  @Query('Select * from ToDoItem')
  Future<List<ToDoItem>> getAllToDoItem();

  @insert // generate the insertion code for item in the database
  Future<void> insertItem (ToDoItem itm);

  @delete // generate the delete code for item in the database
  Future<void> deleteToDoItem(ToDoItem itm);

  @update // generate the UPDATE SQL code
  Future<void> updateItem(ToDoItem itm);
  
}