import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/models/recipe_model.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<RecipeModel> recipes = <RecipeModel>[];
  TextEditingController textEditingController = new TextEditingController();

  String appID = "20eec9d6";
  String appKey = "b962b5b8337320fb4960b6ab63c8cd93";

  getRecipes(String query) async {
    String url = "https://api.edamam.com/search?q=$query&app_id=20eec9d6&app_key=b962b5b8337320fb4960b6ab63c8cd93";

    var response = await http.get(url);
    print("${response.toString()} this is response");
    Map<String, dynamic> jsonData = jsonDecode(response.body);

    jsonData["hits"].forEach((element) {
      print(element.toString());
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xff213A50),
                  const Color(0xff071930)
                ]
              )
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: Platform.isAndroid? 60: 30, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Recipes",
                      style: TextStyle(
                        color: Colors.yellow,
                        fontFamily: "Montserrat",
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text("Welcome",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 20,
                    color: Colors.white
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: textEditingController,
                          decoration: InputDecoration(
                            hintText: "Enter ingredients",
                            hintStyle: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 18,
                              color: Colors.white.withOpacity(0.4)
                            )
                          ),
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 18,
                            color: Colors.white
                          ),
                        ),
                      ),
                      SizedBox(width: 16,),
                      InkWell(
                        onTap: () {
                          if (textEditingController.text.isNotEmpty){
                            print("do it");
                          } else {
                            print("don't do it");
                          }
                        },
                        child: Container(
                          child: Icon(Icons.search, color: Colors.white,),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}
