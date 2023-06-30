import 'package:flutter/material.dart';

class CustomGradient extends StatelessWidget {
  final double startStop, endStop;
  final Alignment begin, end;
  final Color firstColor, secondColor;
  const CustomGradient(
      {super.key,
      required this.startStop,
      required this.endStop,
      required this.end,
      required this.begin,
      required this.firstColor,
      required this.secondColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: begin,end: end, stops: [
        startStop,
        endStop
      ], colors: [
        firstColor,
        secondColor,
      ]))),
    );
  }
}
