
import 'package:floor/floor.dart';

@entity
class ToDoItem
{
  static int ID = 1;

  @primaryKey
  final int id; //can't modify it
  final String item; //can't modify it

  ToDoItem(this.id, this.item);
}
