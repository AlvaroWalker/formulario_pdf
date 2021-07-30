import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formulario_pdf/item_list_page.dart';
import 'package:formulario_pdf/model/invoicelist.dart';
import 'package:formulario_pdf/page/pdf_page.dart';
import 'package:formulario_pdf/tela_inicial.dart';
import 'package:formulario_pdf/variaveis.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'metodo_pag_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());

  // listaDeItens = await carregarPedidos();
}

Future<InvoiceList> carregarPedidos() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String jsonList = prefs.getString('teste1').toString();

  Map<String, dynamic> mapList = jsonDecode(jsonList);

  InvoiceList lista = InvoiceList.fromJson(mapList);

  return lista;
}

class MyApp extends StatelessWidget {
  static final String title = 'pdf';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primaryColor: Color(0xFFFF7E00),
          primarySwatch: Colors.deepOrange,
          backgroundColor: Color.fromARGB(255, 210, 210, 210),
        ),
        home: TelaInicio(),
        //home: MetodoPagamentoPage(),
      );
}
