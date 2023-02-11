import 'package:auto_size_text/auto_size_text.dart';
import 'package:diet_junkie/design.dart';
import 'package:diet_junkie/provider/consumed_aliments.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CellCalendar extends HookConsumerWidget {
  bool selected;
  DateTime day;
  DateTime day2;
  bool? outRange;

  CellCalendar({
    required this.selected,
    required this.day,
    required this.day2,
    this.outRange,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(context, WidgetRef ref) {
    return Center(
        child: Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: outRange == true
                    ? (selected == false ? brown75 : brown)
                    : (selected == false ? brown : yellow),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Column(children: [
              Text(
                day.day.toString(),
                style: whiteTextStyle(20),
              ),
              ref.watch(ConsumedAlimentProvider.calorieByDay(day)).when(
                  loading: () => const Center(child: Text('0')),
                  error: (err, stack) => Center(child: Text(err.toString())),
                  data: (ideas) {
                    return AutoSizeText(
                      ideas.toStringAsFixed(0),
                      maxLines: 1,
                      style: lowWhiteTextStyle(15),
                    );
                  }),
            ])));
  }
}
