import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scheduler/src/features/scheduler/domain/schedule.dart';

part 'schedule_state.freezed.dart';

@freezed
class ScheduleState with _$ScheduleState {
  const factory ScheduleState({
    @Default([]) List<Schedule> schedules,
  }) = _ScheduleState;
}
