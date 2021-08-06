import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:formulario_pdf/model/invoice.dart';
import 'package:formulario_pdf/model/invoicelist.dart';
import 'package:formulario_pdf/tela_itens_enviados.dart';
import 'package:formulario_pdf/variaveis.dart';

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
  Widget build(BuildContext context) {
    listaDeItens.invoices
        .removeWhere((element) => element.customer?.name == null);
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
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 200,
                ),
                SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    fixedSize: Size(MediaQuery.of(context).size.width * .6, 55),
                    onPrimary: Colors.black87,
                    primary: Color.fromARGB(255, 255, 255, 255),
                    shape: StadiumBorder(),
                  ),
                  onPressed: () async {
                    botaoOrcamento();
                  },
                  child: Text(
                    'ORÇAMENTO',
                    style: TextStyle(
                        //color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 4,
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * .6, 55),
                      onPrimary: Colors.black87,
                      primary: Color.fromARGB(255, 255, 255, 255),
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
                        .add(Invoice(id: novoId, items: <InvoiceItem>[]));

                    indexOfId = listaDeItens.invoices
                        .indexWhere((Invoice element) => element.id == novoId);

                    print(indexOfId.toString() + novoId.toString());

                    idNovoPedido = indexOfId;

                    print(listaDeItens.invoices
                        .indexWhere((Invoice element) => element.id == novoId));

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaCliente(
                                id: novoId,
                                editing: false,
                                indexOfId: listaDeItens.invoices.indexWhere(
                                    (Invoice element) =>
                                        element.id == novoId))));
                  },
                  child: Text(
                    'PEDIDO',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  thickness: 3,
                  color: Colors.transparent,
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      //elevation: 4,
                      shadowColor: Colors.transparent,
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * .6, 55),

                      //onPrimary: Colors.black87,
                      primary: Color.fromARGB(0, 0, 0, 0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: Colors.white, width: 2)),
                      minimumSize: Size(80, 50)),
                  onPressed: () async {
                    if (listaDeItens.invoices.isEmpty) {
                      listaDeItens = InvoiceList(invoices: []);
                    }
                    listaDeItens.invoices.removeWhere(
                        (element) => element.customer?.name == null);

                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaItensEnviados()));
                  },
                  child: Text(
                    'MEUS ENVIOS',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  botaoOrcamento() async {
    int indexOfId = 0;
    novoId = 0;
    if (listaDeItens.invoices.isEmpty) {
      listaDeItens = InvoiceList(invoices: []);
    }

    while (
        listaDeItens.invoices.any((Invoice element) => element.id == novoId)) {
      novoId++;

      print(idRepetido);
      idRepetido = true;
    }

    listaDeItens.invoices.add(new Invoice(id: novoId, items: <InvoiceItem>[]));

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
                  indexOfId: listaDeItens.invoices
                      .indexWhere((Invoice element) => element.id == novoId),
                ))).then((value) => null);
  }

  botaoPedido() async {}
}
