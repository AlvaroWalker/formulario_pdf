//import '../flutter_flow/flutter_flow_theme.dart';
//import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:google_fonts/google_fonts.dart';
//import 'package:formulario_pdf/model/invoicelist.dart';

import 'package:money2/money2.dart';

import 'variaveis.dart';

final real = Currency.create('Real', 2,
    symbol: 'R\$', invertSeparators: true, pattern: 'S #.##0,00');

double valorTotal = 0;

class ResumoWidget extends StatefulWidget {
  final int index;
  ResumoWidget({Key? key, required this.index}) : super(key: key);

  @override
  _ResumoWidgetState createState() => _ResumoWidgetState();
}

class _ResumoWidgetState extends State<ResumoWidget> {
  @override
  Widget build(BuildContext context) {
    if (listaDeItens.invoices[widget.index].items.isNotEmpty) {
      valorTotal = listaDeItens.invoices[widget.index].items
          .map((item) => item.unitPrice!.toDouble() * item.quantity!.toDouble())
          .reduce((item1, item2) => item1 + item2);
      //valorTotal.toStringAsFixed(2);
    } else {
      valorTotal = 0;
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Color(0xFFF5F5F5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: criarTabela(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cliente: ${listaDeItens.invoices[widget.index].customer?.name}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          'CNPJ: ${listaDeItens.invoices[widget.index].customer?.doc}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    //'R\$ $valorTotal',

                    Money.from(valorTotal, real).toString(),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget criarTabela() {
    if (listaDeItens.invoices[widget.index].items.isNotEmpty) {
      return Table(
        columnWidths: {0: FractionColumnWidth(.1), 3: FractionColumnWidth(.2)},
        //border: TableBorder.all(),
        children: [
          for (var items in listaDeItens.invoices[widget.index].items)
            TableRow(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            items.quantity.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10,
                            ),
                          ),
                        ),
                      )
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                          child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          items.tipo.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                          ),
                        ),
                      ))
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              items.description.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                              ),
                            )),
                      )
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                          child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: items.unitPrice!.toDouble() != 0
                            ? Text(
                                Money.from(
                                        (items.unitPrice!.toDouble() *
                                            items.quantity!.toDouble()),
                                        real)
                                    .toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 10,
                                ),
                              )
                            : Text('MATERIAL',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 10,
                                )),
                      ))
                    ]),
              ],
            ),
        ],
      );
    }
    return Text('LISTA VAZIA');
  }
}
