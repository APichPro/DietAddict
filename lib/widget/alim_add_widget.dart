import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_junkie/design.dart';
import 'package:diet_junkie/object/aliment.dart';
import 'package:diet_junkie/provider/selected_aliments.dart';
import 'package:diet_junkie/widget/alims_select_widget.dart';
import 'package:diet_junkie/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AlimAdd extends HookConsumerWidget {
  AlimAdd({super.key});
  final scanProvider = StateProvider<bool>((ref) => true);
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
            child: CustomTextField(
                controller: editingController, onchanged: (value) {}),
          ),
          Expanded(
            flex: 13,
            child: ref.watch(scanProvider) == true
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: QRBarScannerCamera(
                        fit: BoxFit.cover,
                        onError: (context, error) => Text(
                          error.toString(),
                          style: TextStyle(color: Colors.red),
                        ),
                        qrCodeCallback: (code) {},
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
                            onTap: () {},
                            selected: false,
                          );
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
