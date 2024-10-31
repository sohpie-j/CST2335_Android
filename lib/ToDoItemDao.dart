
import 'package:floor/floor.dart';
import 'package:my_cst2335_labs/ToDoItem.dart';

@dao
abstract class ToDoItemDao {

  //return items from the databse
  @Query('Select * from ToDoItem')
  Future<List<ToDoItem>> getAllToDoItem();

  //insert, delete, update
  @insert
  void addNewToDoItem (ToDoItem tdi);

  @delete
  void deleteToDoItem(ToDoItem itm);

  @update
  void updateItem(ToDoItem itm);
  
}