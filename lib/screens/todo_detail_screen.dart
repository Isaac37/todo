import 'package:flutter/material.dart';
import 'package:todo/models/todo_model.dart';

class TodoDetailScreen extends StatelessWidget {
  const TodoDetailScreen({super.key, required this.todo});
  final Todo todo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tittle: ${todo.title}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Tittle: ${todo.description}',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Tittle: ${todo.isCompleted ? "Yes" : "No"}',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
