import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_junkie/object/consumed_aliment.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ConsumedAlimentProvider {
  static final consumedAlimentStream =
      StreamProvider.autoDispose<List<ConsumedAliment>>((ref) {
    DateTime date = DateTime.now();
    DateTime zero = DateTime(date.year, date.month, date.day);
    DateTime minuit =
        DateTime(date.year, date.month, date.day).add(const Duration(days: 1));
    final stream = FirebaseFirestore.instance
        .collection('utilisateur')
        .doc('aristide.pichereau@gmail.com')
        .collection('aliments_user')
        .where("timestamp", isGreaterThan: zero)
        .orderBy("timestamp")
        .snapshots();
    return stream.map((snapshot) => snapshot.docs
        .map((doc) => ConsumedAliment.fromJsonFireBase(doc.data(), doc))
        .toList());
  });

  static final calorieByDay =
      FutureProvider.family.autoDispose<double, DateTime>((ref, date) {
    DateTime zero = DateTime(date.year, date.month, date.day);
    DateTime minuit =
        DateTime(date.year, date.month, date.day).add(const Duration(days: 1));
    final calorie = FirebaseFirestore.instance
        .collection('utilisateur')
        .doc('aristide.pichereau@gmail.com')
        .collection('aliments_user')
        .where("timestamp", isGreaterThan: zero)
        .where("timestamp", isLessThan: minuit)
        .get()
        .then((value) => value.docs.fold<double>(
            0, (previousValue, element) => previousValue + element["calorie"]));
    return calorie;
  });

  static final dataByDay =
      FutureProvider.family.autoDispose<Map, DateTime>((ref, date) {
    Map returnMap = {
      "calorie": 0.0,
      "protide": 0.0,
      "lipide": 0.0,
      "glucide": 0.0,
      'calorieW': 0.0,
      'protideW': 0.0,
      'lipideW': 0.0,
      'glucideW': 0.0,
    };
    DateTime zero = DateTime(date.year, date.month, date.day);
    DateTime minuit =
        DateTime(date.year, date.month, date.day).add(const Duration(days: 1));
    DateTime lundi = DateTime(date.year, date.month, date.day)
        .subtract(Duration(days: date.weekday - 1));
    DateTime dimanche =
        DateTime(lundi.year, lundi.month, lundi.day).add(Duration(days: 7));
    FirebaseFirestore.instance
        .collection('utilisateur')
        .doc('aristide.pichereau@gmail.com')
        .collection('aliments_user')
        .where("timestamp", isGreaterThan: zero)
        .where("timestamp", isLessThan: minuit)
        .get()
        .then((value) {
      for (var element in value.docs) {
        returnMap["calorie"] += element["calorie"];
        returnMap["protide"] += element["protide"];
        returnMap["lipide"] += element["lipide"];
        returnMap["glucide"] += element["glucide"];
      }
    });
    FirebaseFirestore.instance
        .collection('utilisateur')
        .doc('aristide.pichereau@gmail.com')
        .collection('aliments_user')
        .where("timestamp", isGreaterThan: lundi)
        .where("timestamp", isLessThan: dimanche)
        .orderBy("timestamp")
        .get()
        .then((value) {
      for (var element in value.docs) {
        returnMap["calorieW"] += (element["calorie"] / 7);
        returnMap["protideW"] += (element["protide"] / 7);
        returnMap["lipideW"] += (element["lipide"] / 7);
        returnMap["glucideW"] += (element["glucide"] / 7);
      }
    });
    return returnMap;
  });

  static final deleteAlimentFromFirebase =
      FutureProvider.family.autoDispose<void, String>((ref, id) {
    return FirebaseFirestore.instance
        .collection('utilisateur')
        .doc('aristide.pichereau@gmail.com')
        .collection('aliments_user')
        .doc(id)
        .delete();
  });
}
