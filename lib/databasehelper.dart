import 'package:sqflite/sqflite.dart';

import 'data/model/todo.dart';

class DatabaseHelper {
  static late Database _database;
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._internal() {
    _databaseHelper = this;
  }
  factory DatabaseHelper()=>_databaseHelper??DatabaseHelper._internal();
  Future<Database> get database async{
    _database = await _initializeDb();
    return _database;
  }
  static const String _tableName='todos';

  Future<Database> _initializeDb() async{
    var path = await getDatabasesPath();
    var db = openDatabase(
      "$path/todo_db.db",
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE $_tableName(id INTEGER PRIMARY KEY,title TEXT, detail TEXT)');
      },
      version: 1,
    );
    return db;
  }
  Future<void> insertTodo(Todo todo) async{
    final Database db = await database;
    await db.insert(_tableName, todo.toMap());
    print('Data inserted');
  }
  Future<List<Todo>> getTodos() async{
    final Database db = await database;
    List<Map<String,dynamic>> results = await db.query(_tableName);
    return results.map((res)=> Todo.fromMap(res)).toList();
  }
}