import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'api/pdf_api.dart';
import 'api/pdf_invoice_api.dart';
import 'variaveis.dart';

class PaginaGerandoPdf extends StatefulWidget {
  final int index;
  final bool jaPedido;
  const PaginaGerandoPdf(
      {Key? key, required this.index, required this.jaPedido})
      : super(key: key);

  @override
  _PaginaGerandoPdfState createState() => _PaginaGerandoPdfState();
}

class _PaginaGerandoPdfState extends State<PaginaGerandoPdf> {
  @override
  Widget build(BuildContext context) {
    print(widget.jaPedido);
    Future.delayed(const Duration(milliseconds: 3000), () {
// Here you can write your code
      gerarPDF(widget.jaPedido);
    });

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
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CircularProgressIndicator(),
                ])
              ],
            ),
          ),
        ),
      ],
    );
  }

  gerarPDF(bool ped) async {
    print('-----------');
    print('-----------');
    print('-----------');
    print(ped);
    print('-----------');
    print('-----------');
    print('-----------');
    if (ped == false) {
      final pdfFile = await PdfInvoiceApi.generate(
          listaDeItens.invoices[widget.index], ped);

      await PdfApi.openFile(pdfFile).then(
          (value) => Navigator.popUntil(context, (route) => route.isFirst));
    } else {
      final pdfFile = await PdfInvoiceApi.generateOnlyPedido(
          listaDeItens.invoices[widget.index], ped);

      await PdfApi.openFile(pdfFile).then(
          (value) => Navigator.popUntil(context, (route) => route.isFirst));
    }

    //pdfGeneratedFile = pdfFile;
  }
}
