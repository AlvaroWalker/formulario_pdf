import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:souza_autocenter/model/invoicelist.dart';
import 'package:souza_autocenter/tela_inicial.dart';
import 'package:souza_autocenter/variaveis.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme/custom_theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  listaDeItens = await carregarPedidos();

  nomeVendedor = await carregarNomeVendedor();

  foneVendedor = await carregarFoneVendedor();
  runApp(MyApp());
}

Future<String> carregarNomeVendedor() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String nome = prefs.getString('vendedorNome').toString();

  if (nome != 'null') {
    return nome;
  } else {
    return '';
  }
}

Future<String> carregarFoneVendedor() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String fone = prefs.getString('vendedorFone').toString();

  if (fone != 'null') {
    return fone;
  } else {
    return '';
  }
}

Future<InvoiceList> carregarPedidos() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String jsonList = prefs.getString('teste1').toString();

  if (jsonList != 'null') {
    Map<String, dynamic> mapList = jsonDecode(jsonList);

    InvoiceList lista = InvoiceList.fromJson(mapList);

    return lista;
  } else {
    return InvoiceList(invoices: []);
  }
}

class MyApp extends StatelessWidget {
  static final String title = 'pdf';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: CustomTheme.lightTheme,
        home: TelaInicio(),
        //home: MetodoPagamentoPage(),
      );
}
