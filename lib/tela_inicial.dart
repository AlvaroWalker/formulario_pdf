import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:souza_autocenter/model/invoice.dart';
import 'package:souza_autocenter/model/invoicelist.dart';
import 'package:souza_autocenter/tela_itens_enviados.dart';
import 'package:souza_autocenter/variaveis.dart';

import 'package:url_launcher/url_launcher.dart';

import 'tela_cliente.dart';

//InvoiceList? listaDeItens;
const _url = 'https://issdigitalsod.com.br/nfse/';
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
            elevation: 0,
            leading: IconButton(
                icon: const Icon(
                  Icons.picture_as_pdf,
                  color: Colors.transparent,
                  size: 37,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TelaInicio()),
                  );
                }),

            title: Text(''),
            backgroundColor:
                Colors.transparent, // <-- APPBAR WITH TRANSPARENT BG
            // <-- ELEVATION ZEROED
          ),
          body: Padding(
              padding: EdgeInsets.all(0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  botoesMenu(),
                ],
              )),
        ),
      ],
    );
  }

  botaoOrcamento() async {}

  botaoPedido() async {}

  botoesMenu() {
    return AnimationLimiter(
        child: AnimationLimiter(
            child: AnimationConfiguration.staggeredList(
                position: 1,
                child: SlideAnimation(
                    delay: Duration(milliseconds: 500),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              height: (MediaQuery.of(context).size.height / 4),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 4,
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width * .6, 55),
                                onPrimary: Colors.black87,
                                primary: Colors.white,
                                shape: StadiumBorder(),
                              ),
                              onPressed: () async {
                                int indexOfId = 0;
                                novoId = 0;
                                if (listaDeItens.invoices.isEmpty) {
                                  listaDeItens = InvoiceList(invoices: []);
                                }

                                while (listaDeItens.invoices.any(
                                    (Invoice element) =>
                                        element.id == novoId)) {
                                  novoId++;

                                  //  print(idRepetido);
                                  //idRepetido = true;
                                }

                                listaDeItens.invoices.add(Invoice(
                                    id: novoId, items: <InvoiceItem>[]));

                                indexOfId = listaDeItens.invoices.indexWhere(
                                    (Invoice element) => element.id == novoId);

                                //print(indexOfId.toString() + novoId.toString());

                                idNovoPedido = indexOfId;

                                listaDeItens.invoices.removeWhere((element) =>
                                    element.customer?.name == null &&
                                    element.id != novoId);

                                listaDeItens.invoices.forEach((element) {
                                  //print(element.id);
                                });
                                abriuOrcamento = false;
                                abriuPedido = false;

                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TelaCliente(
                                              id: novoId,
                                              editing: false,
                                              indexOfIdd: indexOfId,
                                            )));
                              },
                              child: Text(
                                'NOVO ORÇAMENTO',
                                style:
                                    TextStyle(fontSize: 17, color: Colors.grey),
                              ),
                            ),
                            SizedBox(
                              height: 23,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 4,
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width * .6,
                                      55),
                                  onPrimary: Colors.black87,
                                  primary: Colors.white,
                                  shape: StadiumBorder(),
                                  minimumSize: Size(80, 50)),
                              onPressed: () {
                                int indexOfId = 0;
                                novoId = 0;
                                if (listaDeItens.invoices.isEmpty) {
                                  listaDeItens = InvoiceList(invoices: []);
                                }

                                while (listaDeItens.invoices.any(
                                    (Invoice element) =>
                                        element.id == novoId)) {
                                  novoId++;

                                  //   print(idRepetido);
                                  idRepetido = true;
                                }

                                listaDeItens.invoices.add(Invoice(
                                    id: novoId,
                                    orcamento: false,
                                    pedido: true,
                                    items: <InvoiceItem>[]));

                                indexOfId = listaDeItens.invoices.indexWhere(
                                    (Invoice element) => element.id == novoId);

                                //    print(indexOfId.toString() + novoId.toString());

                                idNovoPedido = indexOfId;

                                //  print(listaDeItens.invoices
                                //      .indexWhere((Invoice element) => element.id == novoId));

                                listaDeItens.invoices.removeWhere((element) =>
                                    element.customer?.name == null &&
                                    element.id != novoId);
                                abriuOrcamento = false;
                                abriuPedido = true;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TelaCliente(
                                            id: novoId,
                                            editing: false,
                                            indexOfIdd: listaDeItens.invoices
                                                .indexWhere((Invoice element) =>
                                                    element.id == novoId))));
                              },
                              child: Text(
                                'NOVO PEDIDO',
                                style:
                                    TextStyle(fontSize: 17, color: Colors.grey),
                              ),
                            ),
                            SizedBox(
                              height: 23,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  //elevation: 4,
                                  shadowColor: Colors.transparent,
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width * .6,
                                      55),

                                  //onPrimary: Colors.black87,
                                  primary: Color.fromARGB(0, 255, 102, 0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(
                                          //color: Palette.primary, width: 2)),
                                          color: Colors.red,
                                          width: 2)),
                                  minimumSize: Size(80, 50)),
                              onPressed: () async {
                                if (listaDeItens.invoices.isEmpty) {
                                  listaDeItens = InvoiceList(invoices: []);
                                }
                                listaDeItens.invoices.removeWhere((element) =>
                                    element.customer?.name == null);

                                listaDeItens.invoices.removeWhere((element) =>
                                    element.orcamento == false &&
                                    element.pedido == false);

                                //listaDeItens.invoices.clear();

                                abriuOrcamento = false;
                                abriuPedido = false;

                                log(jsonEncode(listaDeItens.toJson()));

                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TelaItensEnviados()));
                              },
                              child: Text(
                                'MEUS ENVIOS',
                                style: TextStyle(
                                    //color: Palette.primary, fontSize: 18),
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ),
                            Divider(
                              indent: 20,
                              endIndent: 30,
                            ),
                            Divider(
                              indent: 20,
                              endIndent: 30,
                            ),
                            ElevatedButton.icon(
                              icon:
                                  Image.asset('assets/imagens/icon_whats.png'),
                              onPressed: () async {
                                await canLaunch(_url)
                                    ? await launch(_url)
                                    : throw 'Could not launch $_url';
                              },
                              label: Text('EMITIR NOTA FISCAL'),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(15),
                                  elevation: 4,
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width * .6,
                                      55),
                                  onPrimary: Colors.grey,
                                  primary: Colors.white,
                                  shape: StadiumBorder(),
                                  minimumSize: Size(80, 50)),
                            ),
                            SizedBox(
                              height: 23,
                            ),
                          ],
                        ),
                      ],
                    )))));
  }
}
