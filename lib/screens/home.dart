import 'dart:io';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text("Welcome",
                  style: TextStyle(
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
                          decoration: InputDecoration(
                            hintText: "Enter ingredients",
                            hintStyle: TextStyle(
                              fontSize: 18
                            )
                          ),
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),
                      ),
                      SizedBox(width: 16,),
                      Container(
                        child: Icon(Icons.search),
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
