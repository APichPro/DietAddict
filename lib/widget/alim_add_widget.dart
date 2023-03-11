import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_junkie/design.dart';
import 'package:diet_junkie/object/aliment.dart';
import 'package:diet_junkie/provider/open_foodfact_request.dart';
import 'package:diet_junkie/provider/selected_aliments.dart';
import 'package:diet_junkie/widget/alims_select_widget.dart';
import 'package:diet_junkie/widget/custom_textfield.dart';
import 'package:diet_junkie/widget/scanned_aliment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final scanProvider = StateProvider<bool>((ref) => false);

class AlimAdd extends HookConsumerWidget {
  AlimAdd({super.key});
  final barCodeProvider = StateProvider<String>((ref) => '');
  final searchProvider = StateProvider<String>((ref) => '');
  static final getAllFireBaseAliments =
      FutureProvider.autoDispose<List<Aliment>>((ref) {
    final dataList = FirebaseFirestore.instance.collection('aliments').get();
    return dataList.then((value) => value.docs
        .map((doc) => Aliment.fromJsonFireBase(doc.data(), doc))
        .toList());
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController editingController = TextEditingController();
    return Container(
      decoration: BoxDecoration(
        color: brown75,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: ref.watch(scanProvider)
                ? ref
                    .watch(OFFProvider.offAlimentProvider(
                        ref.watch(barCodeProvider)))
                    .when(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (err, stack) =>
                            const Center(child: Text('Scan Barcode')),
                        data: (ideas) => ScannedAliment(
                            selectedAliment: ideas,
                            onPressed: (() => ref
                                .watch(ListAlimAddNotifier.provider.notifier)
                                .addRemConsumedAliment(ideas))))
                : CustomTextField(
                    controller: editingController, onchanged: (value) {}),
          ),
          Expanded(
            flex: 10,
            child: ref.watch(scanProvider)
                ? ClipRRect(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: QRBarScannerCamera(
                        fit: BoxFit.cover,
                        onError: (context, error) => Text(
                          error.toString(),
                          style: TextStyle(color: Colors.red),
                        ),
                        qrCodeCallback: (code) {
                          ref.read(barCodeProvider.notifier).state = code!;

                          /*.watch(ListAlimAddNotifier.provider.notifier)
                              .addRemConsumedAliment(
                                  ConsumedAliment.fromAliment(
                                      ref.watch(OFFProvider.offAlimentProvider(
                                          code!)),
                                      'aristide.pichereau@gmail.com ',
                                      0));*/
                        },
                      ),
                    ),
                  )
                : ref.watch(getAllFireBaseAliments).when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (err, stack) =>
                          Center(child: Text(err.toString())),
                      data: (ideas) => GridView.builder(
                        shrinkWrap: true,
                        itemCount: ideas.length,
                        itemBuilder: ((context, index) {
                          return AlimWidget(
                              aliment: ideas[index],
                              onTap: () {
                                print(ideas[index].calorie);
                                ref
                                    .watch(
                                        ListAlimAddNotifier.provider.notifier)
                                    .addRemConsumedAliment(
                                      ideas[index],
                                    );
                              },
                              selected: ref
                                  .watch(ListAlimAddNotifier.provider.notifier)
                                  .select(ideas[index].nom));
                        }),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                        ),
                      ),
                    ),
          ),
          Flexible(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => ref.read(scanProvider.notifier).state = false,
                    child: Container(
                      decoration: BoxDecoration(
                        color: yellow50,
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(10)),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.dashboard_customize,
                          size: 50,
                          color: white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 1,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => ref.read(scanProvider.notifier).state = true,
                    child: Container(
                      decoration: BoxDecoration(
                        color: yellow50,
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(10)),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.qr_code_scanner,
                          size: 50,
                          color: white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
