import 'dart:convert';

import 'package:flutter_app/post_model.dart';
import 'package:http/http.dart';

class HttpService {
  final String url = "https://api.edamam.com/search";

  Future<List<Post>> getPosts() async {

    Response res = await get(url);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

    }
  }

}