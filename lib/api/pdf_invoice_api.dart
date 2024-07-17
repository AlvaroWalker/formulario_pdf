import 'package:flutter/services.dart';
import 'package:souza_autocenter/model/customer.dart';
import 'package:souza_autocenter/model/invoice.dart';
import 'package:souza_autocenter/model/supplier.dart';
import 'package:souza_autocenter/theme/custom_theme.dart';
import 'package:souza_autocenter/utils.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfInvoiceApi {
  static Future<Uint8List> generateOnlyPedido(
      Invoice invoice, bool pedido, bool orcamento) async {
    final pdf2 = Document();

    final imagemFundo = (await rootBundle.load('assets/orcamentoPag1.jpg'))
        .buffer
        .asUint8List();

    final orcamentoTopImage =
        (await rootBundle.load('assets/pdf/orcamento/orcamento_top.jpg'))
            .buffer
            .asUint8List();

    final orcamentoBottomImage =
        (await rootBundle.load('assets/pdf/orcamento/orcamento_bottom.jpg'))
            .buffer
            .asUint8List();

    final pedidoTopImage =
        (await rootBundle.load('assets/pdf/pedido/pedido_top.jpg'))
            .buffer
            .asUint8List();

    final pedidoBottomImage =
        (await rootBundle.load('assets/pdf/pedido/pedido_bottom.jpg'))
            .buffer
            .asUint8List();

//parte do orçamento
    if (orcamento == true) {
      pdf2.addPage(MultiPage(
        pageTheme: PageTheme(
            margin:
                const EdgeInsets.only(left: 70, right: 70, top: 30, bottom: 10),
            pageFormat: PdfPageFormat.a4,
            buildBackground: (Context context) {
              return FullPage(
                  ignoreMargins: true, child: Image(MemoryImage(imagemFundo)));
            }),
        build: (Context context1) => [
          //SizedBox(height: 1 * PdfPageFormat.cm),
          buildHeader(invoice, orcamentoTopImage),
          SizedBox(height: .5 * PdfPageFormat.cm),
          //buildTitle(invoice),
          buildInvoice(invoice, context1),
          //Divider(),
          buildTotal(invoice, false),
          //buildObsText(invoice),
        ],
        header: (context) {
          if (pdf2.document.pdfPageList.pages.length > 9) {
            return Container(
              width: PdfPageFormat.a4.width / 4,
              //child: Image(MemoryImage(imagemCabecalho2))
            );
          } else {
            return Container();
          }
        },
        footer: (context) {
          return buildFooter(invoice, orcamentoBottomImage, context);
        },
      ));
    }

//parte do pedido
    if (pedido == true) {
      pdf2.addPage(MultiPage(
        pageTheme: PageTheme(
            margin:
                const EdgeInsets.only(left: 70, right: 70, top: 30, bottom: 20),
            pageFormat: PdfPageFormat.a4,
            buildBackground: (Context context1) {
              return FullPage(
                  ignoreMargins: true, child: Image(MemoryImage(imagemFundo)));
            }),
        build: (Context context1) => [
          //SizedBox(height: 1 * PdfPageFormat.cm),
          buildHeader(invoice, pedidoTopImage),
          SizedBox(height: .5 * PdfPageFormat.cm),
          //buildTitle(invoice),
          buildInvoice(invoice, context1),
          //Divider(),
          buildTotal(invoice, true),
          //buildObsText(invoice),
        ],
        header: (Context context1) {
          if (context1.pageNumber > 9) {
            return Container(
                //width: PdfPageFormat.a4.width / 4,
                //child: Image(MemoryImage(imagemCabecalho2))
                );
          } else {
            return Container();
          }
        },
        footer: (Context context1) =>
            buildFooter2(invoice, pedidoBottomImage, context1),
      ));
    }

    return await pdf2.save();
  }

  static Widget buildHeader(Invoice invoice, Uint8List imgCabeca) => Column(
        children: [
          //SizedBox(height: 3.9 * PdfPageFormat.cm),
          Container(
              width: PdfPageFormat.a4.width,
              child: Image(MemoryImage(imgCabeca))),

          SizedBox(height: 0.1 * PdfPageFormat.cm),

          Container(
              width: PdfPageFormat.a4.width,
              child: buildCustomerInfo(invoice.customer)),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [],
          ),

          //SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //buildCustomerAddress(invoice.customer),
              //buildInvoiceInfo(invoice.info),
            ],
          ),
        ],
      );

  static Widget buildCustomerInfo(Customer? customer) => Container(
          //width: PdfPageFormat.a4.width,
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text(
                'REPRESENTANTE COMERCIAL: $nomeVendedor  |  CONTATO: $foneVendedor',
                style: TextStyle(fontSize: 5)),
          ]),*/
          SizedBox(height: 0.08 * PdfPageFormat.cm),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Flexible(
              flex: 10,
              child: itemCabecalho('Cliente: ${customer!.name}'),
            ),
            Flexible(
              flex: 4,
              child: itemCabecalho(
                  'Data: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}'),
            ),
          ]),
          SizedBox(height: 1),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Flexible(
              flex: 10,
              child: itemCabecalho('Veículo ${customer.veiculo}'),
            ),
            Flexible(
              flex: 8,
              child: itemCabecalho('Telefone: ${customer.clienteTelefone}'),
            ),
          ]),
          SizedBox(height: 1),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Flexible(
              flex: 10,
              child: itemCabecalho('Razão Social: ${customer.razaoSocial}'),
            ),
            Flexible(
              flex: 5,
              child: itemCabecalho('CPF/CNPJ: ${customer.doc}'),
            ),
          ]),
          SizedBox(height: 1),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Flexible(
              flex: 10,
              child: itemCabecalho('Endereço: ${customer.clienteEndereco}'),
            ),
          ]),
          SizedBox(height: 1),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Flexible(
                flex: 8,
                child: itemCabecalho('Bairro: ${customer.clienteBairro}')),
            Flexible(
              flex: 11,
              child: itemCabecalho('Cidade: ${customer.clienteCidade}'),
            ),
          ]),
        ],
      ));

  static Widget itemCabecalho(String texto) {
    return Padding(
        padding: const pw.EdgeInsets.all(1),
        child: Container(
            alignment: Alignment.centerLeft,
            height: 15,
            decoration: BoxDecoration(
              border: Border.all(color: PdfColors.grey700, width: .6),
              borderRadius: const BorderRadius.all(
                  Radius.circular(5.0) //         <--- border radius here
                  ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 5, top: 3, bottom: 3),
              child: Text(texto,
                  textScaleFactor: .7,
                  style: const TextStyle(color: PdfColor(.2, .2, .2))),
            )));
  }

  static Widget buildInvoiceInfo(InvoiceInfo info) {
    //final paymentTerms = '${info.dueDate!.difference(info.date).inDays} dias';
    final titles = <String>['cod:', 'data:', 'pagamento:', 'validade:'];
    final data = <String>[
      // info.number,
      // Utils.formatDate(info.date),
      // paymentTerms,
      // Utils.formatDate(info.dueDate),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildSupplierAddress(Supplier supplier) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(supplier.name.toString(),
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 0.2 * PdfPageFormat.mm),
          Text(supplier.address.toString()),
        ],
      );

  static Widget buildTitle(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'xxxxxx',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.1 * PdfPageFormat.cm),
          // Text(invoice.info.description),
          SizedBox(height: 0.1 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(Invoice invoice, Context context) {
    final headers = [
      'Tipo',
      'Descrição',
      'Qtd.',
      'Und',
      'Unitario',
      'Valor Total'
    ];
    final data = invoice.items.map((item) {
      final total = item.unitPrice! * item.quantity!;

      return [
        //   Utils.formatDate(item.date),

        item.tipo,
        item.description!,
        '${item.quantity}',
        item.unidade,
        item.unitPrice != 0
            ? '${Utils.formatarValor(item.unitPrice!)}'
            : 'PEÇAS',
        total != 0 ? '${Utils.formatarValor(total)}' : 'PEÇAS',
      ];
    }).toList();

    return Container(
      alignment: Alignment.topLeft,
      //height: 259,
      decoration: BoxDecoration(
        border: Border.all(color: PdfColors.grey700, width: .5),
        borderRadius: const BorderRadius.all(
            Radius.circular(5.0) //         <--- border radius here
            ),
      ),
      child: TableHelper.fromTextArray(
        headers: headers,
        data: data,
        cellPadding:
            const EdgeInsets.only(left: 6, right: 5, top: 2, bottom: 2),
        border: const TableBorder(
          verticalInside: BorderSide(width: 1, color: PdfColors.grey800),
        ),
        headerStyle: TextStyle(
            fontWeight: FontWeight.bold, color: PdfColors.white, fontSize: 7),
        headerDecoration: const BoxDecoration(
          color: PdfColors.grey700,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              topLeft: Radius.circular(5) //         <--- border radius here
              ),
        ),
        cellHeight: 2,
        cellStyle: const TextStyle(fontSize: 6),
        columnWidths: {
          0: const FlexColumnWidth(5.3),
          1: const FlexColumnWidth(14),
          2: const FlexColumnWidth(2.3),
          3: const FlexColumnWidth(3.0),
          4: const FlexColumnWidth(3.4),
          5: const FlexColumnWidth(4.0),
        },
        cellAlignments: {
          0: Alignment.centerRight,
          1: Alignment.centerLeft,
          2: Alignment.centerRight,
          3: Alignment.centerLeft,
          4: Alignment.centerLeft,
          5: Alignment.centerLeft,
        },
      ),
    );
  }

  static Widget buildTotal(Invoice invoice, bool pedid) {
    final netTotal = invoice.items
        .map((item) => item.unitPrice! * item.quantity!)
        .reduce((item1, item2) => item1 + item2);
    final total = netTotal;

    if (!pedid) {
      return Container(
        alignment: Alignment.topCenter,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                flex: 9,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.topLeft,
                        height: 150,
                        width: 500,
                        decoration: BoxDecoration(
                          color: PdfColors.grey100,
                          border:
                              Border.all(color: PdfColors.grey700, width: .5),
                          borderRadius: const BorderRadius.all(Radius.circular(
                                  5.0) //         <--- border radius here
                              ),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                                'Observações: \n\n'
                                '${invoice.observacoesPedido}',
                                style: const TextStyle(fontSize: 6))),
                      ),
                    ])),
            Spacer(flex: 1),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Container(
                      decoration: BoxDecoration(
                        //color: PdfColors.grey200,
                        border: Border.all(color: PdfColors.grey700, width: .5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)
                                //         <--- border radius here
                                ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: buildText(
                            title: 'EXEC. DOS SERVIÇOS: ',
                            titleStyle: TextStyle(
                              fontSize: 7,
                              fontWeight: FontWeight.bold,
                            ),
                            value: invoice.prazoServico,
                            unite: true,
                          ))),
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: corPdf, width: .5),
                        borderRadius: const BorderRadius.all(Radius.circular(
                                5.0) //         <--- border radius here
                            ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: buildText(
                            title: 'COND. PAG.: ',
                            titleStyle: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                            value: invoice.metPagamento,
                            unite: true,
                          ))),
                  Container(
                      decoration: BoxDecoration(
                        color: PdfColors.grey200,
                        border: Border.all(color: PdfColors.grey700, width: .5),
                        borderRadius: const BorderRadius.all(Radius.circular(
                                5.0) //         <--- border radius here
                            ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: buildText(
                            title: 'TOTAL: ',
                            titleStyle: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            value: Utils.formatarValor(total),
                            unite: true,
                          ))),
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        alignment: Alignment.topCenter,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 7,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.topLeft,
                        height: 150,
                        width: 500,
                        decoration: BoxDecoration(
                          color: PdfColors.grey100,
                          border:
                              Border.all(color: PdfColors.grey700, width: .5),
                          borderRadius: const BorderRadius.all(Radius.circular(
                                  5.0) //         <--- border radius here
                              ),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                                'Observações: \n\n'
                                '${invoice.observacoesPedido}',
                                style: const TextStyle(fontSize: 6))),
                      ),
                    ])),
            Spacer(flex: 1),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Container(
                      child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: buildText(
                            title: '',
                            titleStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            value: '',
                            unite: true,
                          ))),
                  Container(
                      decoration: const BoxDecoration(
                          //border: Border.all(color: corPdf, width: .5),
                          //borderRadius: BorderRadius.all(Radius.circular(
                          //        5.0) //         <--- border radius here
                          //    ),
                          ),
                      child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: buildText(
                            title: '',
                            titleStyle: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            value: '',
                            unite: true,
                          )))
                ],
              ),
            )
          ],
        ),
      );
    }
  }

  static Widget buildObsText(Invoice invoice) {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Container(
          alignment: Alignment.topLeft,
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            color: PdfColor.fromHex('EDF1F2'),
            border: Border.all(color: const PdfColor(1, .5, .1), width: .5),
            borderRadius: const BorderRadius.all(
                Radius.circular(5.0) //         <--- border radius here
                ),
          ))
    ]);
  }

  static Widget buildFooter(
      Invoice invoice, Uint8List imagem, Context context) {
    if (context.pagesCount == context.pageNumber) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 100,
              child: Stack(alignment: Alignment.center, children: [
                Image(MemoryImage(imagem)),
                Align(
                    alignment: const Alignment(.9, -1.1),
                    child: Container(
                      width: 180,
                      height: 25,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(invoice.customer!.name,
                                textScaleFactor: .6,
                                style: pw.TextStyle(
                                    color: const PdfColor(.5, .5, .5),
                                    fontWeight: FontWeight.bold)),
                            Text(invoice.customer!.doc,
                                textScaleFactor: .7,
                                style: const pw.TextStyle(
                                  color: PdfColor(.5, .5, .5),
                                )),
                          ]),
                    )),
              ]))
        ],
      );
    } else {
      return Text('');
    }
  }

  static Widget buildFooter2(
      Invoice invoice, Uint8List imagem, Context context) {
    double abc = .05;
    if (context.pagesCount == context.pageNumber) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              alignment: pw.Alignment.center,
              height: 150,
              child: Stack(alignment: Alignment.center, children: [
                Image(MemoryImage(imagem)),
                Align(
                    alignment: Alignment(.9, .59 - abc),
                    child: Text(invoice.prazoServico,
                        textScaleFactor: .55, textAlign: TextAlign.right)),
                Align(
                    alignment: Alignment(.9, .34 - abc),
                    child: Text(invoice.metPagamento,
                        textScaleFactor: .55, textAlign: TextAlign.right)),
                Align(
                    alignment: Alignment(.9, 0.11 - abc),
                    child: Text(Utils.formatarValor(invoice.valorTotal),
                        textScaleFactor: .7,
                        textAlign: TextAlign.right,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                Align(
                    alignment: const Alignment(1.1, -.92),
                    child: Container(
                      width: 180,
                      height: 25,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(invoice.customer!.name,
                                textScaleFactor: .6,
                                style: pw.TextStyle(
                                    color: const PdfColor(.5, .5, .5),
                                    fontWeight: FontWeight.bold)),
                            Text(invoice.customer!.doc,
                                textScaleFactor: .7,
                                style: const pw.TextStyle(
                                  color: PdfColor(.5, .5, .5),
                                )),
                          ]),
                    ))
              ]))
        ],
      );
    } else {
      return Text('');
    }
  }

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
