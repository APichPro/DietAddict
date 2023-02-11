import 'package:diet_junkie/design.dart';
import 'package:diet_junkie/object/aliment.dart';
import 'package:diet_junkie/provider/consumed_aliments.dart';
import 'package:diet_junkie/widget/alim_add_widget.dart';
import 'package:diet_junkie/widget/background_container.dart';
import 'package:diet_junkie/widget/display_total.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddPage extends HookConsumerWidget {
  AddPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        const BackgroundContainer(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Diet Addict'),
            backgroundColor: Colors.transparent,
          ),
          body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5), child: AlimAdd()),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              height: 185,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: brown75,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ref
                  .watch(ConsumedAlimentProvider.consumedAlimentStream)
                  .when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (err, stack) =>
                          Center(child: Text(err.toString())),
                      data: (ideas) {
                        return DisplayTotal(
                            tcal: ideas.fold(
                                0,
                                (previousValue, element) =>
                                    previousValue + element.calorie),
                            tglu: ideas.fold(
                                0,
                                (previousValue, element) =>
                                    previousValue + element.glucide),
                            tlip: ideas.fold(
                                0,
                                (previousValue, element) =>
                                    previousValue + element.lipide),
                            tprot: ideas.fold(
                                0,
                                (previousValue, element) =>
                                    previousValue + element.protide),
                            diffCal: true,
                            displayObj: true);
                      }),
            ),
          ),
        ),
      ],
    );
  }
}
