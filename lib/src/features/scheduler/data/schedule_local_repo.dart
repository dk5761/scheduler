// local db database.

import 'package:scheduler/src/features/scheduler/data/schedule_database.dart';
import 'package:scheduler/src/features/scheduler/domain/schedule.dart';

class ScheduleRepository {
  // final _db = ScheduleDatabase();

  final ScheduleDatabase _scheduleDatabase;

  ScheduleRepository(this._scheduleDatabase);

  Future<List<Schedule>> getSchedule() async {
    return _scheduleDatabase.getSchedule();
  }

  Future<Schedule> addSchedule(Schedule schedule) async {
    return _scheduleDatabase.insert(schedule);
  }

  Future<void> updateSchedule(Schedule schedule) async {
    return _scheduleDatabase.update(schedule);
  }

  Future<void> deleteSchedule(int id) async {
    return _scheduleDatabase.delete(id);
  }
}
