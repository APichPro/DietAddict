import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:diet_junkie/object/aliment.dart';
import 'dart:convert';

class OFFProvider {
  static final offAlimentProvider = FutureProvider.family
      .autoDispose<Aliment, String>((ref, codeBarre) async {
    var response = await http.get(Uri.parse(
        'https://world.openfoodfacts.org/api/v0/product/$codeBarre.json'));
    if (response.statusCode == 200) {
      var parsedResponse = jsonDecode(response.body);
      Aliment alim = Aliment.fromJsonOpenFoodFact(parsedResponse);
      return alim;
    } else {
      throw Exception();
    }
  });
}
