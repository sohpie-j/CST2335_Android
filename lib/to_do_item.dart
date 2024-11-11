import 'package:floor/floor.dart';

@Entity(tableName: 'ToDoItem')
class ToDoItem {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String content;

  ToDoItem({this.id, required this.content});
}

