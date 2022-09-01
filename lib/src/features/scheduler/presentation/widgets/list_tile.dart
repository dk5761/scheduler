import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduler/src/features/scheduler/domain/schedule.dart';
import 'package:scheduler/src/features/scheduler/presentation/pages/schedule_controller.dart';

import '../../../../utils/alarm_scheduler.dart';

// implement dismissible

class CustomListTile extends ConsumerStatefulWidget {
  const CustomListTile({Key? key, required this.data}) : super(key: key);

  final Schedule data;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomListTileState();
}

class _CustomListTileState extends ConsumerState<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final schedulesProvider = ref.watch(scheduleProvider.notifier);

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(6)),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title
              Text(
                widget.data.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 8,
              ),
              Wrap(
                direction: Axis.vertical,
                spacing: 5,
                children: [
                  Text(
                    "The mode will be set to ${widget.data.mode} ",
                    softWrap: true,
                    style: const TextStyle(
                        fontSize: 11,
                        color: Color.fromARGB(255, 160, 159, 159)),
                  ),
                  Text(
                    "at ${widget.data.time}",
                    softWrap: true,
                    style: const TextStyle(
                        fontSize: 11,
                        color: Color.fromARGB(255, 160, 159, 159)),
                  ),
                ],
              )
            ],
          ),
          Switch.adaptive(
            value: widget.data.active > 0 ? true : false,
            onChanged: (value) {
              schedulesProvider.changeStatus(widget.data, value);
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          )
        ],
      ),
    );
  }
}
