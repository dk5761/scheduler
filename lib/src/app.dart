import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduler/src/features/scheduler/presentation/pages/home_page.dart';
import 'package:scheduler/src/features/scheduler/presentation/pages/new_update_schedule_page.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Builder(builder: (context) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Daily Task',
        themeMode: ThemeMode.dark,
        home: NewSchedule(),
      );
    });
  }
}
