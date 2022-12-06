import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getThemeData(BuildContext context) {
  return ThemeData(
    primaryColor: Colors.black,
    cardColor: const Color(0xffF2F2F2),
    cardTheme: const CardTheme(color: Colors.grey),
    backgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        color: Colors.transparent,
        elevation: 0.0,
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20,
            fontFamily: GoogleFonts.poppins().fontFamily)),
    colorScheme: Theme.of(context).colorScheme.copyWith(
          onSecondary: Colors.white,
          primary: Colors.black,
          secondary: Colors.black,
        ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: Colors.grey,
      selectionHandleColor: Colors.grey,
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusColor: const Color(0xffF5F5F5),
      filled: true,
      labelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontFamily: GoogleFonts.poppins().fontFamily),
      hintStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w500,
          fontFamily: GoogleFonts.poppins().fontFamily),
      floatingLabelStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: GoogleFonts.poppins().fontFamily),
      focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(10),
        borderSide:const BorderSide(
          color: Colors.black,
        ),
      ),
      enabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        borderSide:const BorderSide(
          color:  Color(0xffF5F5F5),
        ),
      ),
      errorBorder:OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ) ,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ) ,
      contentPadding: const EdgeInsets.all(14),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
        elevation: MaterialStateProperty.all(0),
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 24,
          fontFamily: GoogleFonts.poppins().fontFamily),
      headline2: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 20,
          fontFamily: GoogleFonts.poppins().fontFamily),
      headline3: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          fontFamily: GoogleFonts.poppins().fontFamily),
      headline4: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          fontFamily: GoogleFonts.poppins().fontFamily),
      headline5: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w300,
          fontSize: 12,
          fontFamily: GoogleFonts.poppins().fontFamily),
    ),
  );
}
