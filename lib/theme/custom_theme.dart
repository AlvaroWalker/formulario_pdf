import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';

import '../material_color_generator.dart';

PdfColor corPdf = PdfColor.fromHex('#808080');
PdfColor corPdfClara = PdfColor.fromHex('#666666');

final ThemeData tema = ThemeData(
  primarySwatch: generateMaterialColor(Palette.primary),
);

class Palette {
  static const Color primary = Color(0xFFeead0e);
}

class CustomTheme {
  static ThemeData get lightTheme {
    //1
    return ThemeData(
        //2
        primaryColor: Palette.primary,
        primarySwatch: generateMaterialColor(Palette.primary),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Montserrat', //3
        textTheme: TextTheme(),
        buttonTheme: ButtonThemeData(
          // 4
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          //buttonColor: Palette.primary,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: Palette.primary,
              width: 1,
            ),
          ),
        ));
  }
}
