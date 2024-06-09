import 'package:flutter/material.dart';
import 'package:todo/services/db_service.dart';

import '../models/todo_model.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [];
  List<Todo> _completedTodos = [];

  List<Todo> get todos => _todos;
  List<Todo> get completedTodos => _completedTodos;

  Future<void> loadTodos() async {
    _todos = await DbService().fetchTodos();
    _completedTodos = _todos.where((todo) => !todo.isCompleted).toList();
    _todos = _todos.where((todo) => !todo.isCompleted).toList();
    notifyListeners();
  }

  Future<void> addTodo(Todo todo) async {
    await DbService().insertTodo(todo);

    if (todo.isCompleted) {
      _completedTodos.add(todo);
    } else {
      _todos.add(todo);
    }
    notifyListeners();
  }

  Future<void> deleteTodo(String id) async {
    await DbService().deleteTodo(id);
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }
}
