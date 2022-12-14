import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduler/src/common/custom_button.dart';
import 'package:scheduler/src/features/scheduler/presentation/pages/schedule_controller.dart';

import '../../../../common/ringermode.dart';
import '../../domain/schedule.dart';

class NewSchedule extends ConsumerStatefulWidget {
  const NewSchedule({Key? key, this.isUpdate = false, this.schedule})
      : super(key: key);

  final bool isUpdate;
  final Schedule? schedule;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewScheduleState();
}

class _NewScheduleState extends ConsumerState<NewSchedule> {
  TimeOfDay selectedTime = TimeOfDay.now();
  late final TextEditingController _textEditingController;

  RMode _ringerMode = RMode.normal;
  String title = "";
  double _currentSliderValue = 0;
  String? errorText;

  //refs

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }

  DateTime _convertToDateTime() {
    final now = DateTime.now();
    return DateTime(
        now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
  }

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController(
        text: widget.isUpdate ? widget.schedule!.title : "");

    if (widget.isUpdate) {
      selectedTime = TimeOfDay.fromDateTime(widget.schedule!.time);
      _ringerMode = widget.schedule!.mode;
      _currentSliderValue = widget.schedule!.volume + 0.0;
    }

    _textEditingController.addListener(() {
      if (errorText != null) {
        setState(() {
          errorText = null;
        });
      }
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheduleStateProvider = ref.watch(scheduleProvider.notifier);

    Future<void> saveToDb() async {
      log("title : $title");
      log("convertToDateTime : ${_convertToDateTime()}");
      log("ringerMode : $_ringerMode");
      log("slidervalue : ${_currentSliderValue.toInt()}");
      // Navigator.pop(context);

      if (widget.isUpdate) {
        scheduleStateProvider.updateSchedule(
            widget.schedule!.id as int,
            title,
            widget.schedule!.active > 0 ? true : false,
            _ringerMode,
            _convertToDateTime(),
            _currentSliderValue.toInt());
      } else {
        if (title.isNotEmpty) {
          scheduleStateProvider.addSchedule(title, true, _ringerMode,
              _convertToDateTime(), _currentSliderValue.toInt());
        } else {
          setState(() {
            errorText = "Please enter a value";
          });
        }
      }
      //Navigate to home
      AutoRouter.of(context).pop();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text(
          "New Schedule",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black54)),
                onPressed: () {
                  _selectTime(context);
                },
                child: const Text(
                  "Choose Time",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(selectedTime.format(context).toString()),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Title",
            style: TextStyle(fontSize: 22),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
                border: const OutlineInputBorder(), errorText: errorText),
            onChanged: (value) {
              title = value;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Ringer Mode",
            style: TextStyle(fontSize: 22),
          ),
          const SizedBox(
            height: 10,
          ),
          DropdownButton<RMode>(
              value: _ringerMode,
              items: RMode.values.map((RMode e) {
                return DropdownMenuItem(
                    value: e, child: Text(e.name.toString()));
              }).toList(),
              onChanged: (RMode? value) {
                setState(() {
                  _ringerMode = value!;
                  if (value != RMode.normal) {
                    _currentSliderValue = 0;
                  }
                });
              }),
          const SizedBox(
            height: 10,
          ),
          _ringerMode == RMode.normal
              ? Slider(
                  value: _currentSliderValue,
                  max: 100,
                  divisions: 10,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                )
              : const SizedBox(),
          CustomButton(
            text: "Save",
            textStyle: const TextStyle(color: Colors.white),
            onTap: saveToDb,
          )
        ]),
      ),
    );
  }
}
