import 'package:floor/floor.dart';
import 'package:my_cst2335_labs/to_do_item.dart';


@dao
abstract class ToDoItemDao {
  @Query('SELECT * FROM ToDoItem')
  Future<List<ToDoItem>> findAllToDoItems();

  @insert
  Future<void> insertToDoItem(ToDoItem item);

  @Query('DELETE FROM ToDoItem WHERE content = :content')
  Future<void> deleteToDoItemByContent(String content);
}
