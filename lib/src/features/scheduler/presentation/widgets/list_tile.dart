import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// implement dismissible

class CustomListTile extends ConsumerStatefulWidget {
  const CustomListTile({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomListTileState();
}

class _CustomListTileState extends ConsumerState<CustomListTile> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(6)),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title
              const Text(
                "Title",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: const [
                  Text(
                    "The mode will be set to RINGERMODE",
                    style: TextStyle(fontSize: 12
                        // fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    " at DateTime",
                    style: TextStyle(fontSize: 12
                        // fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              )
            ],
          ),
          Switch.adaptive(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          )
        ],
      ),
    );
  }
}
