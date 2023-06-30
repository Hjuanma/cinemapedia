import 'package:flutter/material.dart';

class CustomGradient extends StatelessWidget {
  final List<double> stops;
  final Alignment begin, end;
  final List<Color> colors;
  const CustomGradient(
      {super.key,
      this.end = Alignment.centerLeft,
      this.begin = Alignment.centerRight,
      required this.stops,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: begin, end: end, stops: stops, colors: colors))),
    );
  }
}
