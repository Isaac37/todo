import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/todo_model.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text(DateFormat('yyyy-MM-dd').format(todo.dueDate)),
        title: Text(todo.title),
        subtitle: Text(todo.description),
        trailing: Icon(
          todo.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: todo.isCompleted ? Colors.green : Colors.grey,
        ),
      ),
    );
  }
}
