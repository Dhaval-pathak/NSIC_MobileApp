import "package:flutter/material.dart";

class themeData{
  static ThemeData light= ThemeData(
    appBarTheme: AppBarTheme(
      color: Color(0xff6149F1)
    ),
    primaryColor: Color(0xff6149F1),
    // primarySwatch: Color(0xff6149F1),
      fontFamily: "poppins",
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: Colors.black
      )
    ),
      hintColor: Color(0xffabafb1),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff6149F1),
        )
  )

  );
}