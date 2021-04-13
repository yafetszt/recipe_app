import 'dart:convert';
import 'package:flutter_app/models/hits.dart';
import 'package:http/http.dart' as http;

class Recipe {
  List<Hits> hits = [];

  Future<void> getRecipe() async {
    String url =
        "https://api.edamam.com/search?q=banana&app_id=20eec9d6&app_key=b962b5b8337320fb4960b6ab63c8cd93";
    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    jsonData["hits"].forEach((element) {
      Hits hits = Hits(
        recipeModel: element['recipe'],
      );
    });
  }
}
