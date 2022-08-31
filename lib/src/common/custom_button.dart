import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomButton extends ConsumerWidget {
  const CustomButton(
      {Key? key,
      required this.text,
      required this.onTap,
      this.textStyle,
      this.backgroundColor})
      : super(key: key);

  final String text;
  final VoidCallback onTap;
  final TextStyle? textStyle;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: backgroundColor ?? const Color.fromARGB(255, 188, 187, 187),
            border: Border.all(
              width: 1,
              color: const Color.fromARGB(255, 204, 203, 203),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
