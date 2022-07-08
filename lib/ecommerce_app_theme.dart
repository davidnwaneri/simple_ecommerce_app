import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EcommerceAppTheme {
  static const _black = Colors.black;
  static const _white = Colors.white;
  // Text Styles
  static final lightTextTheme = TextTheme(
    headline1: GoogleFonts.montserrat(color: _black, fontSize: 97, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    headline2: GoogleFonts.montserrat(color: _black, fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    headline3: GoogleFonts.montserrat(color: _black, fontSize: 48, fontWeight: FontWeight.w400),
    headline4: GoogleFonts.montserrat(color: _black, fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headline5: GoogleFonts.montserrat(color: _black, fontSize: 24, fontWeight: FontWeight.w400),
    headline6: GoogleFonts.montserrat(color: _black, fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    subtitle1: GoogleFonts.montserrat(color: _black, fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    subtitle2: GoogleFonts.montserrat(color: _black, fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyText1: GoogleFonts.montserrat(color: _black, fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyText2: GoogleFonts.montserrat(color: _black, fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    button: GoogleFonts.montserrat(color: _black, fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
    caption: GoogleFonts.montserrat(color: _black, fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    overline: GoogleFonts.montserrat(color: _black, fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  );

  static final darkTextTheme = TextTheme(
    headline1: GoogleFonts.montserrat(color: _white, fontSize: 97, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    headline2: GoogleFonts.montserrat(color: _white, fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    headline3: GoogleFonts.montserrat(color: _white, fontSize: 48, fontWeight: FontWeight.w400),
    headline4: GoogleFonts.montserrat(color: _white, fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headline5: GoogleFonts.montserrat(color: _white, fontSize: 24, fontWeight: FontWeight.w400),
    headline6: GoogleFonts.montserrat(color: _white, fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    subtitle1: GoogleFonts.montserrat(color: _white, fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    subtitle2: GoogleFonts.montserrat(color: _white, fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyText1: GoogleFonts.montserrat(color: _white, fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyText2: GoogleFonts.montserrat(color: _white, fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    button: GoogleFonts.montserrat(color: _white, fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
    caption: GoogleFonts.montserrat(color: _white, fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    overline: GoogleFonts.montserrat(color: _white, fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  );

  //Theme Data
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      textTheme: lightTextTheme,
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        backgroundColor: MaterialStateProperty.all(Colors.orange),
        textStyle: MaterialStateProperty.all(darkTextTheme.button),
      )),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.orange,
      ));

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.orange,
      textTheme: darkTextTheme,
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey[900],
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        backgroundColor: MaterialStateProperty.all(Colors.orange),
        textStyle: MaterialStateProperty.all(darkTextTheme.button),
      )),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.orange,
      ),
    );
  }
}
