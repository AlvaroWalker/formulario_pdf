import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';

import '../material_color_generator.dart';

PdfColor corPdf = PdfColor.fromHex('#808080');
PdfColor corPdfClara = PdfColor.fromHex('#666666');

final ThemeData tema = ThemeData(
  primarySwatch: generateMaterialColor(Palette.primary),
);

class Palette {
  static const Color primary = Color.fromARGB(255, 223, 48, 48);
}

class CustomTheme {
  static ThemeData get lightTheme {
    //1
    return ThemeData(
        useMaterial3: true,
        //2
        primaryColor: Palette.primary,
        primarySwatch: generateMaterialColor(Palette.primary),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: GoogleFonts.lexendDeca().fontFamily, //3
        textTheme: TextTheme(),
        buttonTheme: ButtonThemeData(
          // 4
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),

          //buttonColor: Palette.primary,
        ),
        inputDecorationTheme: InputDecorationTheme(
          //fillColor: Colors.blue,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Palette.primary,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              color: Palette.primary,
              width: 1.2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              //color: Color.fromARGB(255, 65, 65, 65),
              width: 1,
            ),
          ),
        ));
  }
}
