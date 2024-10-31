
import 'package:floor/floor.dart';
import 'ToDoItemDao.dart';
import 'ToDoItem.dart';

part 'databse.g.dart';

@Database(version: 1, entities: [ToDoItem])
abstract class ToDoItemDatabase extends FloorDatabase
{
  ToDoItemDao get getDao;

}