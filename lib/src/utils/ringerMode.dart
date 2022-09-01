import 'package:real_volume/real_volume.dart';
import 'package:scheduler/src/common/ringermode.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';

RingerMode setRingerMode(RMode ringerMode) {
  switch (ringerMode) {
    case RMode.normal:
      return RingerMode.NORMAL;
    case RMode.silent:
      return RingerMode.SILENT;
    case RMode.vibrate:
      return RingerMode.VIBRATE;

    default:
      return RingerMode.NORMAL;
  }
}
