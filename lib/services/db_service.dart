import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/todo_model.dart';

class DbService {
  static final DbService _instance = DbService._();
  static Database? _database;

  DbService._();

  factory DbService() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'todo_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE todos(
    id TEXT PRIMARY KEY,
    title TEXT,
    description TEXT,
    dueDate TEXT,
    isCompleted INTEGER
    )
    ''');
  }

  Future<void> insertTodo(Todo todo) async {
    final db = await database;
    await db.insert('todos', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Todo>> fetchTodos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todos');
    return List.generate(maps.length, (i) {
      return Todo.fromMap(maps[i]);
    });
  }

  Future<void> updateTodo(Todo todo) async {
    final db = await database;
    await db
        .update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<void> deleteTodo(String id) async {
    final db = await database;
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
