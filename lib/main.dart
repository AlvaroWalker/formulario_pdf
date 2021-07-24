import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formulario_pdf/item_list_page.dart';
import 'package:formulario_pdf/page/pdf_page.dart';
import 'package:formulario_pdf/tela_inicial.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'pdf';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          backgroundColor: Color.fromARGB(255, 210, 210, 210),
        ),
        home: TelaInicio(),
      );
}
