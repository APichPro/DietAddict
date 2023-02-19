import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_junkie/object/aliment.dart';
import 'package:diet_junkie/object/consumed_aliment.dart';
import 'package:diet_junkie/widget/alims_select_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListAlimAddNotifier extends StateNotifier<List<ConsumedAliment>> {
  ListAlimAddNotifier() : super([]);

  static final provider =
      StateNotifierProvider<ListAlimAddNotifier, List<ConsumedAliment>>(
          (ref) => ListAlimAddNotifier());

  void addRemConsumedAliment(ConsumedAliment value) {
    state.map((e) => e.nom).toList().contains(value.nom)
        ? state = state.where((element) => element.nom != value.nom).toList()
        : state = [...state, value];
  }

  bool select(String value) {
    return state.map((e) => e.nom).toList().contains(value) ? true : false;
  }
}
