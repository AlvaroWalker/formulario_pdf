import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:souza_autocenter/api/pdf_api.dart';
import 'package:souza_autocenter/tela_inicial.dart';
import 'package:flutter/material.dart';

import 'api/pdf_invoice_api.dart';
import 'variaveis.dart';

//import 'package:pdf/widgets.dart' as pw;

//import 'dart:html' as html;

import 'package:universal_html/html.dart' as html;

//import 'package:http/http.dart' as html;

class PaginaGerandoPdf extends StatefulWidget {
  final int index;
  final bool jaPedido;
  const PaginaGerandoPdf(
      {Key? key, required this.index, required this.jaPedido})
      : super(key: key);

  @override
  State<PaginaGerandoPdf> createState() => _PaginaGerandoPdfState();
}

class _PaginaGerandoPdfState extends State<PaginaGerandoPdf> {
  bool criouPDF = false;
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  dynamic feijoada;

  bool orcamentoSelecionado = false;
  bool pedidoSelecionado = false;

  @override
  Widget build(BuildContext context) {
    DateTime datas = DateTime.now();
    //mostrarPDF();

    return Stack(
      // <-- STACK AS THE SCAFFOLD PARENT
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/imagens/tela2.jpg'), // <-- BACKGROUND IMAGE
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
            floatingActionButton: Visibility(
                visible: criouPDF,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                )),
            backgroundColor:
                Colors.transparent, // <-- SCAFFOLD WITH TRANSPARENT BG
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                  icon: const Icon(
                    Icons.home_filled,
                    size: 37,
                  ),
                  onPressed: () async {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TelaInicio()));
                  }),

              title: const Text(''),
              backgroundColor:
                  Colors.transparent, // <-- APPBAR WITH TRANSPARENT BG
              // <-- ELEVATION ZEROED
            ),
            body: Center(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: const Color.fromARGB(50, 255, 255, 255),
                    width: MediaQuery.sizeOf(context).width / 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: orcamentoSelecionado,
                                onChanged: (value) {
                                  setState(() {
                                    orcamentoSelecionado = value!;
                                  });
                                },
                              ),
                              const Text('ORÇAMENTO')
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: pedidoSelecionado,
                                onChanged: (value) {
                                  setState(() {
                                    pedidoSelecionado = value!;
                                  });
                                },
                              ),
                              const Text('PEDIDO')
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () {
                                if (orcamentoSelecionado == true ||
                                    pedidoSelecionado == true) {
                                  gerarPDF(pedidoSelecionado,
                                      orcamentoSelecionado, datas);
                                }
                              },
                              child: const Text('CRIAR PDF')),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }

  gerarPDF(bool pedido, bool orcamento, DateTime datas) async {
    String nomeArquivo =
        '${listaDeItens.invoices[widget.index].customer?.name} - ${datas.day}.${datas.month}.${datas.year} - ${datas.hour}-${datas.minute}';
    if (orcamento == true) {
      nomeArquivo = '$nomeArquivo - orcamento';
    }
    if (pedido == true) {
      nomeArquivo = '$nomeArquivo - pedido';
    }

    PdfInvoiceApi.generateOnlyPedido(
            listaDeItens.invoices[widget.index], pedido, orcamento)
        .then((value) {
      if (kIsWeb) {
        final url = html.Url.createObjectUrlFromBlob(
            html.Blob([value], 'application/pdf'));
        final anchor = html.document.createElement('a') as html.AnchorElement
          ..href = url
          ..style.display = 'none'
          ..download = '$nomeArquivo.pdf';
        html.document.body?.children.add(anchor);
        anchor.click();
        html.document.body?.children.remove(anchor);
        html.Url.revokeObjectUrl(url);
      } else {
        PdfApi.saveDocument(name: '$nomeArquivo.pdf', pdf: value)
            .then((value) => PdfApi.openFile(value));
      }
    });
  }
}
