import 'package:flutter/material.dart';

import '../data/model/todo.dart';
import '../databasehelper.dart';

class DbProvider extends ChangeNotifier{
  List<Todo> _arrToDo = [];
  late DatabaseHelper _dbHelper;
  List<Todo> get todos => _arrToDo;
  DbProvider(){
    _dbHelper = DatabaseHelper();
    _getAllTodos();
  }

  void _getAllTodos() async {
    _arrToDo = await _dbHelper.getTodos();
    notifyListeners();
  }
  Future<void> addTodo(Todo todo) async{
    await _dbHelper.insertTodo(todo);
    _getAllTodos();
  }
}