import 'package:cloud_firestore/cloud_firestore.dart';

enum Nutriscore { A, B, C, D, E, N }

class Aliment {
  // field
  String? alimentId;
  String referenceId;
  String nom = "";
  double calorie = 0;
  double protide = 0;
  double lipide = 0;
  double glucide = 0;
  String? imageUrl;
  Nutriscore? nutriscore;
  String? ingredient;
  String? marque;
  String? origine;

  // function
  Aliment(
    this.referenceId,
    this.imageUrl,
    this.nom,
    this.calorie,
    this.protide,
    this.lipide,
    this.glucide,
    this.nutriscore,
    this.ingredient,
    this.marque,
    this.origine,
  );

  Map<String, dynamic> toJson() => {
        'referenceId': referenceId,
        'nom': nom,
        imageUrl ?? 'imageUrl': imageUrl,
        'calorie': calorie,
        'protide': protide,
        'lipide': lipide,
        'glucide': glucide,
        //'nutriscore': nutriscore == Nutriscore.N ? nutriscore : null,
        ingredient ?? 'ingredient': ingredient,
        marque ?? 'marque': marque,
        origine ?? 'origine': origine,
      };

  Aliment.fromJsonOpenFoodFact(Map<String, dynamic> json)
      : referenceId = json["product"]["_id"] ?? 'No_data',
        nom = json["product"]["abbreviated_product_name_fr"] ?? 'No_data',
        imageUrl = json["product"]["image_front_url"] ?? 'No_data',
        calorie =
            json["product"]['nutriments']["energy-kcal_100g"].toDouble() ?? 0.0,
        protide = json["product"]['nutriments']["proteins"].toDouble() ?? 0.0,
        lipide = json["product"]['nutriments']["fat"].toDouble() ?? 0.0,
        glucide =
            json["product"]['nutriments']["carbohydrates"].toDouble() ?? 0.0,
        nutriscore = json["product"]["nutriscore_grade"] == 'a'
            ? Nutriscore.A
            : (json["product"]["nutriscore_grade"] == 'b'
                ? Nutriscore.B
                : (json["product"]["nutriscore_grade"] == 'c')
                    ? Nutriscore.C
                    : (json["product"]["nutriscore_grade"] == 'd')
                        ? Nutriscore.D
                        : (json["product"]["nutriscore_grade"] == 'e')
                            ? Nutriscore.E
                            : Nutriscore.N),
        ingredient = json["product"]["ingredients_text"] ?? 'No_data',
        marque = json["product"]["brands"] ?? 'No_data',
        origine = json["product"]["countries"] ?? 'No_data';

  Aliment.fromJsonFireBase(Map<String, dynamic> json, DocumentSnapshot snapshot)
      : referenceId = snapshot.reference.id,
        nom = json["nom"],
        calorie = json["calorie"].toDouble() ?? 0.0,
        protide = json["protide"].toDouble() ?? 0.0,
        lipide = json["lipide"].toDouble() ?? 0.0,
        glucide = json["glucide"].toDouble() ?? 0.0,
        nutriscore = Nutriscore.N;

  factory Aliment.fromSnapshot(DocumentSnapshot snapshot) {
    final newAlim = Aliment.fromJsonFireBase(
        snapshot.data() as Map<String, dynamic>, snapshot);
    return newAlim;
  }
}
