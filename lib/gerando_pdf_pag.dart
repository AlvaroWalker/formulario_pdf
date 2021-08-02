import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'api/pdf_invoice_api.dart';
import 'variaveis.dart';

class PaginaGerandoPdf extends StatefulWidget {
  final int index;
  const PaginaGerandoPdf({Key? key, required this.index}) : super(key: key);

  @override
  _PaginaGerandoPdfState createState() => _PaginaGerandoPdfState();
}

class _PaginaGerandoPdfState extends State<PaginaGerandoPdf> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000), () {
// Here you can write your code
      gerarPDF();
    });

    return Stack(
      // <-- STACK AS THE SCAFFOLD PARENT
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/imagens/splash.jpg'), // <-- BACKGROUND IMAGE
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment(0, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 50,
                          offset: Offset(2, 2),
                          spreadRadius: 1,
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                      shape: BoxShape.rectangle,
                    ),
                    child: Align(
                      alignment: Alignment(0, 0),
                      child: Text(
                        'GERANDO PDF',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  gerarPDF() async {
    final pdfFile =
        await PdfInvoiceApi.generate(listaDeItens.invoices[widget.index]);

    pdfGeneratedFile = pdfFile;
    pdfVisualizado = false;

    Navigator.popUntil(context, (route) => route.isFirst);
  }
}
