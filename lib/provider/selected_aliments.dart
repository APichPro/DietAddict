import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_junkie/object/aliment.dart';
import 'package:diet_junkie/widget/alims_select_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectedAlimentList extends StateNotifier<List<Aliment>> {
  SelectedAlimentList() : super([]);

  static final selectedAlimentProvider =
      StateNotifierProvider<SelectedAlimentList, List<Aliment>>(
          (ref) => SelectedAlimentList());

  //Aliment _current = Aliment();
  //Aliment get current => _current;

  void addSelectedAliment(Aliment selectedAliment) {
    state.add(selectedAliment);
  }
}
