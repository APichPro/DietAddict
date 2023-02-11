import 'package:diet_junkie/design.dart';
import 'package:diet_junkie/page/add_page.dart';
import 'package:diet_junkie/page/calendar_page.dart';
import 'package:diet_junkie/provider/consumed_aliments.dart';
import 'package:diet_junkie/widget/alims_display_widget.dart';
import 'package:diet_junkie/widget/background_container.dart';
import 'package:diet_junkie/widget/display_total.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(children: [
      const BackgroundContainer(),
      Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Diet Addict'),
            backgroundColor: Colors.transparent,
          ),
          drawer: Drawer(
            backgroundColor: yellow50,
            width: 125,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              IconButton(
                icon: Icon(Icons.add),
                iconSize: 50,
                color: white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddPage()),
                  );
                },
              ),
              IconButton(
                iconSize: 50,
                color: white,
                icon: Icon(Icons.calendar_today),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CalendarPage()),
                  );
                },
              )
            ]),
          ),
          body: ref.watch(ConsumedAlimentProvider.consumedAlimentStream).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text(err.toString())),
              data: (ideas) {
                return Padding(
                    padding: EdgeInsets.all(5),
                    child: ListView.builder(
                      itemCount: ideas.length,
                      itemBuilder: (_, index) {
                        return AlimListDisplayWidget(
                            aliment: ideas[index], onPressed: () {});
                      },
                    ));
              }),
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
                        })),
          ))
    ]);
  }
}
