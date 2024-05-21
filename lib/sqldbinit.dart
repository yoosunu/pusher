import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// define class DatabaseHelper
class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  static const String tableName = 'info';

  static const String columnCode = 'code';
  static const String columnTitle = 'title';
  static const String columnLink = 'link';
  static const String columnTimeStamp = 'timeStamp';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String path = join(await getDatabasesPath(), 'info.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS $tableName(
            $columnCode INTEGER,
            $columnTitle TEXT,
            $columnLink TEXT,
            $columnTimeStamp TEXT
          )
          ''');
      },
    );
  }

  Future<void> resetTable() async {
    Database db = await database;

    await db.execute('DROP TABLE IF EXISTS $tableName');

    await db.execute('''
      CREATE TABLE $tableName(
        $columnCode INTEGER,
        $columnTitle TEXT,
        $columnLink TEXT,
        $columnTimeStamp TEXT
      )
    ''');
  }

  Future<int> insertInfo(Map<String, dynamic> info) async {
    Database db = await database;
    return await db.insert(tableName, info);
  }

  Future<List<Map<String, dynamic>>> getData() async {
    Database db = await database;
    return db.query(tableName);
  }
}
