import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static Color mainColor = Color(0xff085bd9);
  static Color bgColor = Color(0xffffffff);
  static Color accentColor = Color(0xff03034d);

  static List<Color> cardsColor = [
    Colors.purple,
    Colors.red.shade300,
    Colors.blue.shade300,
    Colors.pink.shade300,
    Colors.green.shade100,
    Colors.orange.shade100,
    Colors.blueGrey.shade300,
  ];

  static TextStyle mainTitle = GoogleFonts.roboto(
    fontSize:25.0, fontWeight: FontWeight.bold);
  static TextStyle mainContent = GoogleFonts.nunito(
      fontSize:20.0, fontWeight: FontWeight.normal);
  static TextStyle dateTitle = GoogleFonts.roboto(
      fontSize:15.0, fontWeight: FontWeight.w500);
}