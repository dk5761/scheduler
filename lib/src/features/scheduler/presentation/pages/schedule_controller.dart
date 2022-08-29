import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduler/src/common/ringermode.dart';
import 'package:scheduler/src/features/scheduler/domain/schedule.dart';

import '../../data/schedule_database.dart';
import '../../data/schedule_local_repo.dart';
import '../../domain/schedule_state/schedule_state.dart';

final todoViewModelProvider = StateNotifierProvider(
  (ref) => TodoViewModelProvider(
    ref.read,
    ScheduleRepository(ScheduleDatabase()),
  ),
);

class TodoViewModelProvider extends StateNotifier<ScheduleState> {
  TodoViewModelProvider(this._reader, this._scheduleRepository)
      : super(const ScheduleState()) {
    getSchedules();
  }

  // ignore: unused_field
  final Reader _reader;
  final ScheduleRepository _scheduleRepository;

  Future<void> addSchedule(String title, bool active, RingerMode mode,
      DateTime time, int volume) async {
    final todo = await _scheduleRepository.addSchedule(Schedule(
      title: title,
      active: active,
      mode: mode,
      time: time,
      volume: volume,
    ));

    state = state.copyWith(
      schedules: [todo, ...state.schedules],
    );
  }

  Future<void> getSchedules() async {
    final todos = await _scheduleRepository.getSchedule();

    state = state.copyWith(
      schedules: todos,
    );
  }

  Future<void> changeStatus(Schedule schedule, bool value) async {
    final newSchedule = schedule.copyWith(
      active: value,
    );

    await _scheduleRepository.updateSchedule(newSchedule);

    final schedules = state.schedules
        .map((item) => item.id == newSchedule.id ? newSchedule : item)
        .toList();

    state = state.copyWith(
      schedules: schedules,
    );
  }

  Future<void> deleteSchedule(int scheduleId) async {
    await _scheduleRepository.deleteSchedule(scheduleId);

    final schedules =
        state.schedules.where((item) => item.id != scheduleId).toList();

    state = state.copyWith(
      schedules: schedules,
    );
  }
}
