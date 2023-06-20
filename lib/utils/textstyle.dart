import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextApp {
  // Membuat textStyle yang berisikan fontsize, color, dan fontweight
  TextStyle setTextRoboto(
      double fontSize, Color colorValue, FontWeight fontWeight) {
    return GoogleFonts.roboto(
        textStyle: TextStyle(
            fontSize: fontSize, color: colorValue, fontWeight: fontWeight));
  }
}
