import 'package:diet_junkie/design.dart';
import 'package:flutter/material.dart';

class ColorText extends StatefulWidget {
  double size;
  double ratio;
  String text;
  late Color color;

  ColorText({
    required this.size,
    required this.ratio,
    required this.text,
    Key? key,
  }) : super(key: key) {
    if (ratio >= 90 && ratio <= 110) {
      color = Color.fromARGB(255, 3, 129, 66);
    } else if (ratio >= 75 && ratio <= 125) {
      color = Color.fromARGB(255, 238, 131, 0);
    } else if (ratio < 75 || ratio > 125) {
      color = Color.fromARGB(255, 230, 63, 17);
    } else {
      color = white;
    }
  }

  @override
  _ColorText createState() => _ColorText();
}

class _ColorText extends State<ColorText> {
  @override
  Widget build(context) {
    return Text(
      widget.text,
      style: TextStyle(
        color: widget.color,
        fontFamily: "Unbounded",
        fontSize: widget.size,
      ),
    );
  }
}
