import 'dart:developer';

import 'package:scheduler/src/features/scheduler/domain/schedule.dart';
import 'package:sqflite/sqflite.dart';
import '../../../common/db/app_database.dart';

class ScheduleDatabase extends AppDatabase {
  final String _tableName = 'schedule2';

  Future<List<Schedule>> getSchedule() async {
    final db = await database;
    final maps = await db.query(
      _tableName,
      orderBy: 'id DESC',
    );

    print(maps);

    if (maps.isEmpty) return [];

    return maps.map((map) => Schedule.fromJson(map)).toList();
  }

  Future<Schedule> getOneSchedule(int id) async {
    final db = await database;
    final item = await db.query(_tableName, where: "id = $id");
    final schedule = Schedule.fromJson(item[0]);

    return schedule;
  }

  Future<Schedule> insert(Schedule schedule) async {
    final db = await database;

    final id = await db.insert(
      _tableName,
      schedule.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return schedule.copyWith(
      id: id,
    );
  }

  Future<Schedule> update(Schedule schedule) async {
    final db = await database;

    print(schedule);

    final id = await db.update(
      _tableName,
      schedule.toJson(),
      where: 'id = ?',
      whereArgs: [schedule.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return schedule.copyWith(
      id: id,
    );
  }

  Future delete(int id) async {
    final db = await database;

    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
