import 'package:flutter/material.dart';
import 'package:flutter_app/ui/screens/login.dart';
import 'package:flutter_app/ui/theme.dart';

class RecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipes',
      theme: buildTheme(),
      initialRoute: '/login',
      routes: {
        '/': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
      }
    );
  }
}