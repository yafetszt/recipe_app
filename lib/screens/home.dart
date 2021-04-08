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
            child: Column(
              children: <Widget>[

                Row(
                  children: <Widget>[
                    Text("Recipes", style: TextStyle(
                        color: Colors.white
                    ),)
                  ],
                ),
                SizedBox(height: 30,),

              ],
            ),
          ),
        ],
      )
    );
  }
}
