import 'package:diet_junkie/design.dart';
import 'package:diet_junkie/provider/selected_aliments.dart';
import 'package:flutter/material.dart';
import 'package:diet_junkie/object/aliment.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AlimWidget extends HookConsumerWidget {
  Function() onTap;
  Aliment aliment;
  bool selected;

  AlimWidget({
    required this.aliment,
    required this.onTap,
    required this.selected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(context, WidgetRef ref) {
    return Padding(
        padding: EdgeInsets.all(3),
        child: InkWell(
            onTap: onTap,
            child: Container(
                decoration: BoxDecoration(
                  color: selected ? green : yellow50,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                alignment: Alignment.center,
                child: Column(children: [
                  Text(aliment.calorie.toStringAsFixed(0),
                      style: whiteTextStyle(28), textAlign: TextAlign.center),
                  Text(
                    aliment.nom,
                    maxLines: 2,
                    style: whiteTextStyle(15),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ]))));
  }
}
