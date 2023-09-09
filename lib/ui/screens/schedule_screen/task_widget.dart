import 'package:flutter/material.dart';
import 'package:maiporarisu/ui/styles/color.dart';

class TaskWidget extends StatelessWidget {
  final String text;
  const TaskWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 14,
      decoration: BoxDecoration(
        color: MaiporarisuColor.keyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
