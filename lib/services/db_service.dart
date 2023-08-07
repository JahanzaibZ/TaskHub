import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DatabaseService {
  static const _dbTable = 'tasks';
  static String? _dbPath;
  static Database? _database;

  static Future<void> getDatabasePath() async {
    final dbLoc = await sql.getDatabasesPath();
    _dbPath = path.join(dbLoc, 'TaskHub.db');
  }

  static Future<void> openDatabase() async {
    if (_dbPath == null) {
      await DatabaseService.getDatabasePath();
    }
    _database = await sql.openDatabase(
      _dbPath!,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE $_dbTable (id INTEGER PRIMARY KEY, name TEXT, description TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insertData(Map<String, Object?> data) async {
    if (_database == null) {
      await DatabaseService.openDatabase();
    }
    await _database!.insert(
      _dbTable,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> readData() async {
    if (_database == null) {
      await DatabaseService.openDatabase();
    }
    return _database!.query(_dbTable);
  }

  static Future<void> deleteData(int id) async {
    await _database!.delete(_dbTable, where: 'id = ?', whereArgs: [id]);
  }
}
