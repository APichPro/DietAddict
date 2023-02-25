import 'package:auto_size_text/auto_size_text.dart';
import 'package:diet_junkie/design.dart';
import 'package:diet_junkie/object/aliment.dart';
import 'package:diet_junkie/widget/nutriscore_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScannedAliment extends HookConsumerWidget {
  Aliment selectedAliment;
  Function() onPressed;

  ScannedAliment({
    required this.selectedAliment,
    required this.onPressed,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(context, WidgetRef ref) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Flexible(
          flex: 3,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            AutoSizeText('${selectedAliment.calorie.toString()} Kcal',
                style: blackTextStyle(23), textAlign: TextAlign.center),
            AutoSizeText(
              selectedAliment.nom,
              maxLines: 1,
              style: blackTextStyle(12),
              textAlign: TextAlign.center,
            ),
          ])),
      Expanded(
          flex: 1,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              selectedAliment.protide.toString(),
              style: blackTextStyle(23),
              textAlign: TextAlign.center,
            ),
            Text(
              'Protide',
              style: blackTextStyle(12),
              textAlign: TextAlign.center,
            ),
          ])),
      Expanded(
          flex: 1,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              selectedAliment.lipide.toString(),
              style: blackTextStyle(23),
              textAlign: TextAlign.center,
            ),
            Text(
              'Lipide',
              style: blackTextStyle(12),
              textAlign: TextAlign.center,
            ),
          ])),
      Expanded(
          flex: 1,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              selectedAliment.glucide.toString(),
              style: blackTextStyle(23),
              textAlign: TextAlign.center,
            ),
            Text(
              'Glucide',
              style: blackTextStyle(12),
              textAlign: TextAlign.center,
            ),
          ])),
      Expanded(
          flex: 1,
          child: NutriscoreWidget(
            nutriscore: selectedAliment.nutriscore ?? Nutriscore.N,
          )),
      Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: onPressed,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 60,
          ),
        ),
      ),
    ]);
  }
}
