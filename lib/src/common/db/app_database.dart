import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  late Database _database;
  static const tableName = 'schedule2';
  // static const tableName2 = '${tableName}_days';

  Future<Database> get database async {
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'schedule3.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTable,
    );
  }

  Future<void> _createTable(Database db, int version) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            time TEXT, 
            mode TEXT,
            active INT,
            volume INT
            );
''');
  }
}

// query to get all the data from the table

// SELECT *
// FROM schedule, schedule_days
// WHERE schedule.days_id=schedule_days.id
            