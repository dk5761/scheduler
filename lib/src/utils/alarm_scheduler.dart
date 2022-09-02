// ignore_for_file: non_constant_identifier_names

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:real_volume/real_volume.dart';
import 'package:scheduler/src/common/ringermode.dart';
import 'package:scheduler/src/features/scheduler/data/schedule_database.dart';
import 'package:scheduler/src/features/scheduler/data/schedule_local_repo.dart';
import 'package:scheduler/src/features/scheduler/domain/schedule.dart';
import 'package:scheduler/src/utils/ringerMode.dart';

void AlarmScheduler(Schedule schedule) async {
  await AndroidAlarmManager.periodic(
      const Duration(minutes: 2), schedule.id!, scheduleAlarm,
      startAt: schedule.time, wakeup: true, allowWhileIdle: true, exact: true);
}

void scheduleAlarm(int id) {
  final DateTime now = DateTime.now();
  print("$now for $id");
  setSoundMode(id);
}

void setSoundMode(int id) async {
  final scheduleRepo = ScheduleRepository(ScheduleDatabase());
  final Schedule schedule = await scheduleRepo.getOneSchedule(id);
  // await SoundMode.setSoundMode(setRingerMode(schedule.mode));
  await RealVolume.setRingerMode(setRingerMode(schedule.mode),
      redirectIfNeeded: false);

  if (schedule.mode == RMode.normal) {
    await RealVolume.setVolume(schedule.volume + 0.0);
  }
}

void CancelAlarm(int id) async {
  await AndroidAlarmManager.cancel(id);
}
