import 'dart:async';

import 'package:flutter/material.dart';
import 'package:formulario_pdf/model/invoice.dart';
import 'package:formulario_pdf/model/invoicelist.dart';
import 'package:formulario_pdf/tela_itens_enviados.dart';
import 'package:formulario_pdf/variaveis.dart';

import 'api/pdf_api.dart';
import 'tela_cliente.dart';

//InvoiceList? listaDeItens;

int listSize = 0;
int novoId = 0;
bool idRepetido = true;

int idNovoPedido = 0;

class TelaInicio extends StatefulWidget {
  const TelaInicio({Key? key}) : super(key: key);

  @override
  _TelaInicioState createState() => _TelaInicioState();
}

class _TelaInicioState extends State<TelaInicio> {
  @override
  @override
  Widget build(BuildContext context) {
    if (listaDeItens.invoices.isNotEmpty) {
      if (listaDeItens.invoices[idNovoPedido].customer?.name == null) {
        listaDeItens.invoices.removeAt(idNovoPedido);
      }
    }
    if (pdfGeneratedFile != null) {
      PdfApi.openFile(pdfGeneratedFile);
      pdfGeneratedFile = null;
    }

    return Stack(
      // <-- STACK AS THE SCAFFOLD PARENT
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image:
                  AssetImage('assets/imagens/menu.jpg'), // <-- BACKGROUND IMAGE
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor:
              Colors.transparent, // <-- SCAFFOLD WITH TRANSPARENT BG
          appBar: AppBar(
            title: Text(''),
            backgroundColor:
                Colors.transparent, // <-- APPBAR WITH TRANSPARENT BG
            elevation: 0, // <-- ELEVATION ZEROED
          ),
          body: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/imagens/logo.png'), // <-- BACKGROUND IMAGE
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      onPrimary: Colors.black87,
                      primary: Colors.grey,
                      shape: StadiumBorder(),
                      minimumSize: Size(70, 50)),
                  onPressed: () {
                    int indexOfId = 0;
                    novoId = 0;
                    if (listaDeItens.invoices.isEmpty) {
                      listaDeItens = InvoiceList(invoices: []);
                    }

                    while (listaDeItens.invoices
                        .any((Invoice element) => element.id == novoId)) {
                      novoId++;

                      print(idRepetido);
                      idRepetido = true;
                    }

                    listaDeItens.invoices
                        .add(new Invoice(id: novoId, items: <InvoiceItem>[]));

                    indexOfId = listaDeItens.invoices
                        .indexWhere((Invoice element) => element.id == novoId);

                    print(indexOfId.toString() + novoId.toString());

                    idNovoPedido = indexOfId;

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaCliente(
                                  id: novoId,
                                  editing: false,
                                ))).then((value) => setState(() {}));
                  },
                  child: Text(
                    'ORÇAMENTO',
                    style: TextStyle(
                        //color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 30),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      onPrimary: Colors.black87,
                      primary: Colors.grey,
                      shape: StadiumBorder(),
                      minimumSize: Size(80, 50)),
                  onPressed: () {
                    int indexOfId = 0;
                    novoId = 0;
                    if (listaDeItens.invoices.isEmpty) {
                      listaDeItens = InvoiceList(invoices: []);
                    }

                    while (listaDeItens.invoices
                        .any((Invoice element) => element.id == novoId)) {
                      novoId++;

                      print(idRepetido);
                      idRepetido = true;
                    }

                    listaDeItens.invoices
                        .add(new Invoice(id: novoId, items: <InvoiceItem>[]));

                    indexOfId = listaDeItens.invoices
                        .indexWhere((Invoice element) => element.id == novoId);

                    print(indexOfId.toString() + novoId.toString());

                    idNovoPedido = indexOfId;

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaCliente(
                                  id: novoId,
                                  editing: false,
                                ))).then((value) => setState(() {}));
                  },
                  child: Text(
                    'PEDIDO',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  thickness: 3,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      //onPrimary: Colors.black87,
                      primary: Colors.white,
                      shape: StadiumBorder(),
                      minimumSize: Size(80, 50)),
                  onPressed: () async {
                    if (listaDeItens.invoices.isEmpty) {
                      listaDeItens = InvoiceList(invoices: []);
                    }

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaItensEnviados()));
                  },
                  child: Text(
                    'MEUS ENVIOS',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  abrirPdf() async {
    print(pdfGeneratedFile);
    if (pdfGeneratedFile != null) {
      await PdfApi.openFile(pdfGeneratedFile);
      pdfGeneratedFile = null;
      pdfVisualizado = true;
    }
  }
}
