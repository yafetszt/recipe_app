import 'package:flutter/material.dart';
import 'package:flutter_app/ui/screens/login.dart';
import 'package:flutter_app/ui/theme.dart';
import 'package:flutter_app/ui/screens/home.dart';

class RecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipes',
      theme: buildTheme(),
      routes: {
        '/': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
      }
    );
  }
}