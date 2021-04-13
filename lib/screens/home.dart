import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/models/recipe_model.dart';
import 'package:flutter_app/screens/recipe_view.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  List<RecipeModel> recipes = <RecipeModel>[];
  String ingredients;
  bool _loading;
  String query = "";
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
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
                      ],
                    begin: FractionalOffset.topRight,
                    end: FractionalOffset.bottomLeft,
                  )
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: !kIsWeb ? Platform.isAndroid? 40: 20: 20, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: kIsWeb
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Recipes",
                          style: TextStyle(
                            color: Colors.orangeAccent,
                            fontFamily: "Montserrat",
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: textEditingController,
                              decoration: InputDecoration(
                                  hintText: "Search recipes",
                                  hintStyle: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 18,
                                      color: Colors.white.withOpacity(0.4)
                                  ),
                              ),
                              style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 18,
                                  color: Colors.white
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          InkWell(
                            onTap: () async {
                              if (textEditingController.text.isNotEmpty){
                                setState(() {
                                  _loading = true;
                                });
                                recipes = [];
                                String url =
                                    "https://api.edamam.com/search?q=${textEditingController.text}&app_id=20eec9d6&app_key=b962b5b8337320fb4960b6ab63c8cd93";
                                var response = await http.get(url);
                                Map<String, dynamic> jsonData =
                                jsonDecode(response.body);
                                jsonData["hits"].forEach((element) {
                                  print(element.toString());
                                  RecipeModel recipeModel = new RecipeModel();
                                  recipeModel = RecipeModel.fromMap(element['recipe']);
                                  recipes.add(recipeModel);
                                  print(recipeModel.url);
                                });
                                setState(() {
                                  _loading = false;
                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  gradient: LinearGradient(
                                      colors: [
                                        const Color(0xffA2834D),
                                        const Color(0xffBC9A5F)
                                      ],
                                      begin: FractionalOffset.topRight,
                                      end: FractionalOffset.bottomLeft)),
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    Icons.search,
                                    size: 32,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    Container(
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300, mainAxisSpacing: 20.0
                      ),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      children: List.generate(recipes.length, (index) {
                        return GridTile(
                          child: Tile(
                            title: recipes[index].label,
                            desc: recipes[index].source,
                            imgUrl: recipes[index].image,
                            url: recipes[index].url
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Tile extends StatefulWidget {
  final String title, desc, imgUrl, url;
  Tile({this.title, this.desc, this.imgUrl, this.url});

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  _launchURL(String url) async {
    print(url);
    if(await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget> [
        GestureDetector(
          onTap: () {
            if (kIsWeb) {
            _launchURL(widget.url);
            } else {
              print(widget.url + ": This is what we are going to look at.");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecipeView(
                            postUrl: widget.url,
                          )));
            }
          },
          child: Container(
            margin: EdgeInsets.all(8.0),
            child: Stack(
              children: <Widget>[
                Image.network(
                  widget.imgUrl,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 200,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white30, Colors.white],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                            fontFamily: 'MontserratBold'),
                        ),
                        Text(
                          widget.desc,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black87,
                            fontFamily: 'MontserratItalic'),
                        )
                      ],
                    )
                  ),
                )
              ],
            ),
          ),
        )
      ]
    );
  }
}