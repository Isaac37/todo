import 'package:flutter/material.dart';
import 'package:todo/services/db_service.dart';

import '../models/todo_model.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Future<void> loadTodos() async {
    _todos = await DbService().fetchTodos();
    notifyListeners();
  }

  Future<void> addTodo(Todo todo) async {
    await DbService().insertTodo(todo);
    _todos.add(todo);
    notifyListeners();
  }

  Future<void> deleteTodo(String id) async {
    await DbService().deleteTodo(id);
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }
}
