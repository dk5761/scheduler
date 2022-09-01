import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduler/src/app.dart';
import 'package:real_volume/real_volume.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool? isPermissionGranted = await RealVolume.isPermissionGranted();

  if (!isPermissionGranted!) {
    // Opens Do Not Disturb Access settings to grant the access
    await RealVolume.openDoNotDisturbSettings();
  }

  await AndroidAlarmManager.initialize();

  runApp(ProviderScope(child: MyApp()));
}
