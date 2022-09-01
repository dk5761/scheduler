import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduler/src/features/scheduler/presentation/pages/schedule_controller.dart';
import 'package:scheduler/src/features/scheduler/presentation/widgets/list_tile.dart';
import 'package:scheduler/src/routing/routing.gr.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:scheduler/src/utils/alarm_scheduler.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleList = ref.watch(scheduleProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Schedule Lists",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: scheduleList.schedules.isNotEmpty
              ? ListView.builder(
                  itemCount: scheduleList.schedules.length,
                  itemBuilder: (context, index) {
                    if (scheduleList.schedules[index].active > 0) {
                      AlarmScheduler(scheduleList.schedules[index]);
                    } else {
                      print(scheduleList.schedules);
                      final id = scheduleList.schedules[index].id!;
                      CancelAlarm(id);
                    }

                    return CustomListTile(
                      data: scheduleList.schedules[index],
                    );
                  },
                )
              : const Text(" Schedules ")),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.grey,
        onPressed: (() => AutoRouter.of(context).push(const NewSchedule())),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
