import 'package:auto_size_text/auto_size_text.dart';
import 'package:diet_junkie/design.dart';
import 'package:diet_junkie/provider/selected_aliments.dart';
import 'package:diet_junkie/widget/alim_add_widget.dart';
import 'package:diet_junkie/widget/background_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddPage extends HookConsumerWidget {
  AddPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TextEditingController> _controllers = [];
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
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                height: 185,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: brown75,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(children: [
                    Flexible(
                      flex: 1,
                      child: ListView.builder(
                        itemCount:
                            ref.watch(ListAlimAddNotifier.provider).length,
                        itemBuilder: (_, index) {
                          _controllers.add(TextEditingController());
                          return Container(
                            decoration: BoxDecoration(
                              color: yellow50,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: AutoSizeText(
                                      ref
                                          .watch(ListAlimAddNotifier.provider)[
                                              index]
                                          .nom,
                                      style: blackTextStyle(20),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    )),
                                Flexible(
                                    flex: 1,
                                    child: TextField(
                                      cursorColor: white,
                                      style: whiteTextStyle(20),
                                      onChanged: (value) {
                                        print(value);
                                        ref
                                            .watch(ListAlimAddNotifier
                                                .provider)[index]
                                            .qte = double.parse(value);
                                      },
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      controller: _controllers[index],
                                    ))
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      iconSize: 50,
                      color: white,
                      onPressed: () {
                        ref
                            .watch(ListAlimAddNotifier.provider.notifier)
                            .addAlimentsFirebase();
                      },
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
