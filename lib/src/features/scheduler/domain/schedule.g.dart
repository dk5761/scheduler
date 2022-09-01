// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Schedule _$$_ScheduleFromJson(Map<String, dynamic> json) => _$_Schedule(
      id: json['id'] as int?,
      time: DateTime.parse(json['time'] as String),
      title: json['title'] as String,
      mode: $enumDecode(_$RModeEnumMap, json['mode']),
      active: json['active'] as int,
      volume: json['volume'] as int,
    );

Map<String, dynamic> _$$_ScheduleToJson(_$_Schedule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'time': instance.time.toIso8601String(),
      'title': instance.title,
      'mode': _$RModeEnumMap[instance.mode]!,
      'active': instance.active,
      'volume': instance.volume,
    };

const _$RModeEnumMap = {
  RMode.silent: 'silent',
  RMode.normal: 'normal',
  RMode.vibrate: 'vibrate',
};
