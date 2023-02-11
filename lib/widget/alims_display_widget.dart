import 'package:auto_size_text/auto_size_text.dart';
import 'package:diet_junkie/design.dart';
import 'package:diet_junkie/object/consumed_aliment.dart';
import 'package:flutter/material.dart';

class AlimListDisplayWidget extends StatelessWidget {
  Function() onPressed;
  ConsumedAliment aliment;

  AlimListDisplayWidget({
    required this.aliment,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(context) {
    return Padding(
      padding: EdgeInsets.only(top: 3),
      child: Container(
        decoration: BoxDecoration(
          color: brown75,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      aliment.qte.toStringAsFixed(1),
                      style: blackTextStyle(20),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'g',
                      style: blackTextStyle(10),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(aliment.nom,
                        maxLines: 1,
                        style: blackTextStyle(20),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center),
                    AutoSizeText('${aliment.calorie.toStringAsFixed(1)} Kcal',
                        style: blackTextStyle(20),
                        maxLines: 1,
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
              Flexible(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            aliment.protide.toStringAsFixed(1),
                            style: blackTextStyle(20),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Protide',
                            style: blackTextStyle(10),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            aliment.lipide.toStringAsFixed(1),
                            style: blackTextStyle(20),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Lipide',
                            style: blackTextStyle(10),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            aliment.glucide.toStringAsFixed(1),
                            style: blackTextStyle(20),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Glucide',
                            style: blackTextStyle(10),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: onPressed,
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
