import 'package:diet_junkie/design.dart';
import 'package:diet_junkie/object/aliment.dart';
import 'package:diet_junkie/provider/consumed_aliments.dart';
import 'package:diet_junkie/provider/selected_aliments.dart';
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
                child: Text(
                    ref.watch(ListAlimAddNotifier.provider).length.toString())),
          ),
        ),
      ],
    );
  }
}
