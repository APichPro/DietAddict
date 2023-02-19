import 'package:diet_junkie/design.dart';
import 'package:diet_junkie/object/aliment.dart';
import 'package:diet_junkie/widget/nutriscore_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScannedAliment extends HookConsumerWidget {
  Aliment selectedAliment;

  ScannedAliment({
    required this.selectedAliment,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(context, WidgetRef ref) {
    return Column(children: [
      Flexible(
          flex: 1,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Flexible(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Image.network(
                        selectedAliment.imageUrl ?? 'No data',
                        fit: BoxFit.contain,
                      )),
                )),
            Flexible(
                flex: 2,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${selectedAliment.calorie.toString()} Kcal',
                          style: blackTextStyle(23),
                          textAlign: TextAlign.center),
                      Text(
                        selectedAliment.nom,
                        maxLines: 2,
                        style: blackTextStyle(12),
                        textAlign: TextAlign.center,
                      ),
                    ])),
          ])),
      Flexible(
          flex: 1,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: NutriscoreWidget(
                      nutriscore: selectedAliment.nutriscore ?? Nutriscore.N,
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            selectedAliment!.protide.toString(),
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
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                        ]))
              ])),
      /* if (widget.keyboard == 0.0)
                          Flexible(
                            flex: 1,
                            child: Text(
                              selectedAliment.ingredient ?? 'No_data',
                              style: blackTextStyle(10),
                            ),
                          )*/
    ]);
  }
}
