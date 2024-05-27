import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/providers/todo_provider.dart';
import 'package:uuid/uuid.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dueDateController = TextEditingController();
  final _priorityController = TextEditingController();
  final _estimatedDurationController = TextEditingController();
  DateTime? _selectedDueDate;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dueDateController.dispose();
    _priorityController.dispose();
    _estimatedDurationController.dispose();
    super.dispose();
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDueDate)
      setState(() {
        _selectedDueDate = picked;
      });
  }

  void _saveForm() {
    if (_titleController.text.isEmpty || _selectedDueDate == null) {
      return;
    }
    final String id = const Uuid().v4();
    final String title = _titleController.text;
    final String description = _descriptionController.text;
    final DateTime dueDate = _selectedDueDate!;

    final Todo newTodo = Todo(
      id: id,
      title: title,
      description: description,
      dueDate: dueDate,
      isCompleted: false,
    );

    Provider.of<TodoProvider>(context, listen: false).addTodo(newTodo);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _selectedDueDate == null
                        ? 'No Date Chosen!'
                        : 'Due Date: ${DateFormat('yyyy-MM-dd').format(_selectedDueDate!)}',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () => _selectDueDate(context),
                  child: Text('Choose Date'),
                ),
              ],
            ),
            SizedBox(height: 20),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  _saveForm();
                },
                child: const Text('Add Todo'))
          ],
        ),
      ),
    );
  }
}
