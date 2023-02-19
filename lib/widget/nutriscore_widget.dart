import 'package:diet_junkie/design.dart';
import 'package:diet_junkie/object/aliment.dart';
import 'package:flutter/material.dart';

class NutriscoreWidget extends StatelessWidget {
  Nutriscore nutriscore;

  NutriscoreWidget({
    required this.nutriscore,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(context) {
    Color color;
    String letter;
    switch (nutriscore) {
      case Nutriscore.A:
        color = const Color.fromARGB(255, 3, 129, 66);
        letter = 'A';
        break;
      case Nutriscore.B:
        color = const Color.fromARGB(255, 133, 187, 47);
        letter = 'B';
        break;
      case Nutriscore.C:
        color = const Color.fromARGB(255, 254, 204, 2);
        letter = 'C';
        break;
      case Nutriscore.D:
        color = const Color.fromARGB(255, 238, 131, 0);
        letter = 'D';
        break;
      case Nutriscore.E:
        color = const Color.fromARGB(255, 230, 63, 17);
        letter = 'E';
        break;
      case Nutriscore.N:
        color = const Color.fromARGB(255, 127, 127, 128);
        letter = 'N';
    }
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Center(
          child: Text(
        letter,
        style: whiteTextStyle(30),
        textAlign: TextAlign.center,
      )),
    );
  }
}
