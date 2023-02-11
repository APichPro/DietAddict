import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_junkie/object/aliment.dart';

class ConsumedAliment {
  // field
  DateTime timestamp;
  String? alimentId;
  String referenceId;
  String nom = "";
  double calorie = 0;
  double protide = 0;
  double lipide = 0;
  double glucide = 0;
  String nutriscore;
  double qte = 0;
  String userId;

  // function
  ConsumedAliment.fromAliment(Aliment aliment, String uUserId, double qta)
      : userId = uUserId,
        referenceId = aliment.referenceId,
        nom = aliment.nom,
        calorie = (aliment.calorie * qta) / 100,
        protide = (aliment.protide * qta) / 100,
        lipide = (aliment.lipide * qta) / 100,
        glucide = (aliment.glucide * qta) / 100,
        qte = qta,
        nutriscore = Nutriscore.values.toString(),
        timestamp = DateTime.now();

  Map<String, dynamic> toJsonFireBase() => {
        'userId': userId,
        'referenceId': referenceId,
        'nom': nom,
        'calorie': calorie,
        'protide': protide,
        'lipide': lipide,
        'glucide': glucide,
        'nutriscore': Nutriscore.N.toString(),
        'qte': qte,
        'timestamp': timestamp,
      };

  ConsumedAliment.fromJsonFireBase(
      Map<String, dynamic> json, DocumentSnapshot snapshot)
      : alimentId = snapshot.reference.id,
        userId = json["userId"],
        referenceId = json["referenceId"],
        nom = json["nom"],
        calorie = json["calorie"].toDouble(),
        protide = json["protide"].toDouble(),
        lipide = json["lipide"].toDouble(),
        glucide = json["glucide"].toDouble(),
        nutriscore = json["nutriscore"],
        qte = json["qte"].toDouble(),
        timestamp = json["timestamp"].toDate();

  factory ConsumedAliment.fromSnapshot(DocumentSnapshot snapshot) {
    final newAlim = ConsumedAliment.fromJsonFireBase(
        snapshot.data() as Map<String, dynamic>, snapshot);
    return newAlim;
  }
}
