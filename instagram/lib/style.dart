import 'package:flutter/material.dart';

var theme = ThemeData(
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(backgroundColor: Colors.grey),
    ),
    appBarTheme: AppBarTheme(
        actionsIconTheme: IconThemeData(color: Colors.white, size: 25.0),
        
        ),
    textTheme: TextTheme(bodyText2: TextStyle(color: Colors.black)));
