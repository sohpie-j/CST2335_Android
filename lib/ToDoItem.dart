

import 'package:floor/floor.dart';

@entity //Table will be the class name, variables will be mapped to columns in the table
class ToDoItem{
  static int ID = 1; //This tracks the IDs for the program

  @primaryKey //means this is primary key in table
  final int id; //can't modify it

  final String item;  //can't modify it


  ToDoItem(this.id, this.item)
  {
    if(this.id >= ID)
      ID = this.id+1; //make ID larger than IDs from the database

  }

}