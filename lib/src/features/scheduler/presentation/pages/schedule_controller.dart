import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduler/src/common/ringermode.dart';
import 'package:scheduler/src/features/scheduler/domain/schedule.dart';

import '../../data/schedule_database.dart';
import '../../data/schedule_local_repo.dart';
import '../../domain/schedule_state/schedule_state.dart';

final scheduleProvider =
    StateNotifierProvider<ScheduleController, ScheduleState>(
  (ref) => ScheduleController(
    ref.read,
    ScheduleRepository(ScheduleDatabase()),
  ),
);

class ScheduleController extends StateNotifier<ScheduleState> {
  ScheduleController(this._reader, this._scheduleRepository)
      : super(const ScheduleState()) {
    getSchedules();
  }

  // ignore: unused_field
  final Reader _reader;
  final ScheduleRepository _scheduleRepository;

  Future<void> addSchedule(
      String title, bool active, RMode mode, DateTime time, int volume) async {
    final todo = await _scheduleRepository.addSchedule(Schedule(
      title: title,
      active: active ? 1 : 0,
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

  Future<void> updateSchedule(int id, String title, bool active, RMode mode,
      DateTime time, int volume) async {
    final todo = await _scheduleRepository.updateSchedule(Schedule(
      id: id,
      title: title,
      active: active ? 1 : 0,
      mode: mode,
      time: time,
      volume: volume,
    ));

    // make the state modified
    List schedules = state.schedules.toList();
    //remove the element from the state
    schedules.removeWhere((element) => element.id == id);

    state = state.copyWith(
      schedules: [todo, ...schedules],
    );
  }

  Future<void> changeStatus(Schedule schedule, bool value) async {
    final newSchedule = schedule.copyWith(
      active: value ? 1 : 0,
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
