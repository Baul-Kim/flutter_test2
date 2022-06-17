import 'package:flutter/material.dart';

var theme = ThemeData(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.black
    ),
    textTheme: TextTheme(
    bodyText2: TextStyle(color: Colors.black)
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            backgroundColor: Colors.green,
        )
    ),
    iconTheme: IconThemeData(
        color: Colors.black
    ),
    appBarTheme: AppBarTheme(
        color: Colors.white,
        actionsIconTheme: IconThemeData(
            color: Colors.black,
            size: 40
        ),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20)
    )

);