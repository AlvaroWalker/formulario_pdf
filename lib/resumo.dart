//import '../flutter_flow/flutter_flow_theme.dart';
//import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:google_fonts/google_fonts.dart';
//import 'package:souza_autocenter/model/invoicelist.dart';

import 'package:money2/money2.dart';

import 'utils.dart';
import 'variaveis.dart';

final real = Currency.create('Real', 2,
    symbol: 'R\$', invertSeparators: true, pattern: 'S #.##0,00');

double valorTotal = 0;
const double fontSize = 10;

class ResumoWidget extends StatefulWidget {
  final int index;
  const ResumoWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<ResumoWidget> createState() => _ResumoWidgetState();
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

    listaDeItens.invoices[widget.index].items.sort((a, b) {
      //return

      if (a.tipo == 'REL. DE PEÇAS') {
        String mat = 'ZZZZZZZZZZZZ${a.tipo!}';
        return mat.compareTo(b.tipo.toString());
      } else {
        //String mat = 'ZZZZZZZZZZZZ' + b.tipo!;
        return b.tipo.toString().compareTo(b.tipo.toString());
      }
    });

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: const Color(0xFFFFFFFF),
        shadowColor: const Color.fromARGB(255, 237, 224, 237),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),

        //dentro do box

        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: criarTabela(),
            ),
            const Divider(color: Colors.red),
            const Align(
              alignment: Alignment(-0.7, 0),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
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
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          'VEÍCULO: ${listaDeItens.invoices[widget.index].customer?.veiculo}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    //'R\$ $valorTotal',

                    Utils.formatarValor(valorTotal),

                    style: const TextStyle(
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
        columnWidths: const {
          0: FractionColumnWidth(.1),
          2: FractionColumnWidth(.4)
        },
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
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: fontSize,
                            ),
                          ),
                        ),
                      )
                    ]),
                Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          items.tipo.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: fontSize,
                            //fontWeight: FontWeight.bold
                          ),
                        ),
                      ))
                    ]),
                Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              items.description.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: fontSize,
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
                                Utils.formatarValor(
                                  (items.unitPrice!.toDouble() *
                                      items.quantity!.toDouble()),
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: fontSize,
                                ),
                              )
                            : const Text('PEÇAS',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: fontSize,
                                )),
                      ))
                    ]),
              ],
            ),
        ],
      );
    }
    return const Text('LISTA VAZIA');
  }
}
