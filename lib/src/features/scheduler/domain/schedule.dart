// import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/ringermode.dart';
part 'schedule.freezed.dart';
part 'schedule.g.dart';

@freezed
class Schedule with _$Schedule {
  factory Schedule({
    final int? id,
    required final DateTime time,
    required final String title,
    required final RingerMode mode,
    required final int active,
    required final int volume,
  }) = _Schedule;

  factory Schedule.fromJson(Map<String, Object?> json) =>
      _$ScheduleFromJson(json);
}

// @freezed
// class ScheduleDays with _$ScheduleDays {
//   factory ScheduleDays({
//     required bool monday,
//     required bool tuesday,
//     required bool wednesday,
//     required bool thursday,
//     required bool friday,
//     required bool saturday,
//     required bool sunday,
//   }) = _ScheduleDays;

//   factory ScheduleDays.fromJson(Map<String, Object?> json) =>
//       _$ScheduleDaysFromJson(json);
// }
