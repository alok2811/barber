
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


MaterialColor mainColor = MaterialColor(
  4288971823,
  <int, Color>{
    50: Color.fromRGBO(
      164,
      132,
      47,
      .1,
    ),
    100: Color.fromRGBO(
      164,
      132,
      47,
      .2,
    ),
    200: Color.fromRGBO(
      164,
      132,
      47,
      .3,
    ),
    300: Color.fromRGBO(
      164,
      132,
      47,
      .4,
    ),
    400: Color.fromRGBO(
      164,
      132,
      47,
      .5,
    ),
    500: Color.fromRGBO(
      164,
      132,
      47,
      .6,
    ),
    600: Color.fromRGBO(
      164,
      132,
      47,
      .7,
    ),
    700: Color.fromRGBO(
      164,
      132,
      47,
      .8,
    ),
    800: Color.fromRGBO(
      164,
      132,
      47,
      .9,
    ),
    900: Color.fromRGBO(
      164,
      132,
      47,
      1,
    ),
  },
);

ThemeData myTheme = ThemeData(

  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.white),
    headline2: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.white38),
    subtitle1: TextStyle(fontSize: 12,  color: Colors.white38),
    subtitle2: TextStyle(fontSize: 14,  color: Colors.white, backgroundColor: Color(0xffa4842f)),
    bodyText1: TextStyle(fontSize: 14, color: Colors.white),
    bodyText2: TextStyle(fontSize: 14, color: Color(0xffa4842f).withOpacity(0.5)),
    button: TextStyle(fontSize: 16,color: Colors.white),
  ),
  dividerColor: Color(0xffa4842f).withOpacity(0.7),
  fontFamily: GoogleFonts.roboto().fontFamily,
  primaryColor: Color(0xffa4842f),
  secondaryHeaderColor: Colors.black,
  scaffoldBackgroundColor: Colors.black54,
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xffa4842f),
  ),
  brightness: Brightness.dark,
  primarySwatch: mainColor,

  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      )
  ),
);
