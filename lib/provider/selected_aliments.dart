import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_junkie/object/aliment.dart';
import 'package:diet_junkie/object/consumed_aliment.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListAlimAddNotifier extends StateNotifier<List<Aliment>> {
  ListAlimAddNotifier() : super([]);

  static final provider =
      StateNotifierProvider<ListAlimAddNotifier, List<Aliment>>(
          (ref) => ListAlimAddNotifier());

  void addRemConsumedAliment(Aliment value) {
    state.map((e) => e.nom).toList().contains(value.nom)
        ? state = state.where((element) => element.nom != value.nom).toList()
        : state = [...state, value];
  }

  bool select(String value) {
    return state.map((e) => e.nom).toList().contains(value) ? true : false;
  }

  void addAlimentsFirebase() {
    for (var i = 0; i < state.length; i++) {
      FirebaseFirestore.instance
          .collection('utilisateur')
          .doc('aristide.pichereau@gmail.com')
          .collection('aliments_user')
          .add(ConsumedAliment.fromAliment(
                  state[i], 'aristide.pichereau@gmail.com')
              .toJsonFireBase());
    }
    state = [];
  }
}
