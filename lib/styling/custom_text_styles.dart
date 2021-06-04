import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//For Main Page
TextStyle buildRobotoDrawerTextStyle(
    double fontSize, Color color, FontWeight fontWeight) {
  return GoogleFonts.raleway(
    textStyle: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  );
}

TextStyle buildLogoTextStyle(
    double fontSize, Color color, FontWeight fontWeight) {
  return GoogleFonts.prompt(
      textStyle: TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  ));
}

TextStyle buildRobotoTextStyle(double fontSize, Color color) {
  return GoogleFonts.raleway(
      textStyle: TextStyle(
    fontSize: fontSize,
    color: color,
  ));
}

TextStyle buildBoldRobotoText(double fontSize, Color color) {
  return GoogleFonts.raleway(
      textStyle: TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: FontWeight.bold,
  ));
}

TextStyle buildCrimsonProTextStyle(double fontSize) {
  return GoogleFonts.crimsonPro(
      textStyle: TextStyle(
    fontSize: fontSize,
    color: Colors.black,
  ));
}
