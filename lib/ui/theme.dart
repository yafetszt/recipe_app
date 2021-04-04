import 'package:flutter/material.dart';

ThemeData buildTheme() {
  TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      headline1: base.headline1.copyWith(
        fontFamily: 'Montserrat',
        fontSize: 40.0,
        color: const Color(0xFF807a6b),
      ),
    );
  }


final ThemeData base = ThemeData.light();

return base.copyWith(
  textTheme: _buildTextTheme(base.textTheme),
);
}