import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:formulario_pdf/api/pdf_api.dart';
import 'package:formulario_pdf/model/customer.dart';
import 'package:formulario_pdf/model/invoice.dart';
import 'package:formulario_pdf/model/supplier.dart';
import 'package:formulario_pdf/utils.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();
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

    final imagemCabecalho2 =
        (await rootBundle.load('assets/orcamentoPdfTopPage2.jpg'))
            .buffer
            .asUint8List();

    pdf.addPage(MultiPage(
      pageTheme: PageTheme(
          margin: EdgeInsets.only(left: 70, right: 70, top: 30, bottom: 10),
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
        buildInvoice(invoice, imagemCabecalho2, context1),
        //Divider(),
        buildTotal(invoice, false),
        //buildObsText(invoice),
      ],
      header: (context) {
        if (pdf.document.pdfPageList.pages.length > 9) {
          return Container(
              width: PdfPageFormat.a4.width / 4,
              child: Image(MemoryImage(imagemCabecalho2)));
        } else {
          return Container();
        }
      },
      footer: (context) {
        return buildFooter(invoice, orcamentoBottomImage, context);
      },
    ));

    if (invoice.pedido) {
      pdf2.addPage(MultiPage(
        pageTheme: PageTheme(
            margin: EdgeInsets.only(left: 70, right: 70, top: 30, bottom: 20),
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
          buildInvoice(invoice, imagemCabecalho2, context1),
          //Divider(),
          buildTotal(invoice, true),
          //buildObsText(invoice),
        ],
        header: (Context context1) {
          if (context1.pageNumber > 9) {
            return Container(
                width: PdfPageFormat.a4.width / 4,
                child: Image(MemoryImage(imagemCabecalho2)));
          } else {
            return Container();
          }
        },
        footer: (Context context1) =>
            buildFooter2(invoice, pedidoBottomImage, context1),
      ));
    }

    //PdfMerger.mergeMultiplePDF(paths: [], outputDirPath: outputDirPath)
    return PdfApi.saveDocument(
        name: 'pdf_gerado.pdf', name2: 'pdf_gerado2.pdf', pdf: pdf, pdf2: pdf2);
  }

  static Widget buildHeader(Invoice invoice, Uint8List imgCabeca) => Column(
        children: [
          //SizedBox(height: 3.9 * PdfPageFormat.cm),
          Container(
              width: PdfPageFormat.a4.width,
              child: Image(MemoryImage(imgCabeca))),

          SizedBox(height: 1 * PdfPageFormat.cm),

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
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Flexible(
              flex: 10,
              child: itemCabecalho('Cliente: ' + customer!.name),
            ),
            Flexible(
              flex: 4,
              child: itemCabecalho(
                  'Data: ' + DateFormat('dd/MM/yyyy').format(DateTime.now())),
            ),
          ]),
          SizedBox(height: 1),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Flexible(
              flex: 10,
              child: itemCabecalho(
                  'Razão Social: ' + customer.razaoSocial.toString()),
            ),
            Flexible(
              flex: 5,
              child: itemCabecalho('CPF/CNPJ: ' + customer.doc),
            ),
          ]),
          SizedBox(height: 1),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Flexible(
              flex: 10,
              child: itemCabecalho('Insc.Est.: ' + customer.inscEst.toString()),
            ),
            Flexible(
              flex: 8,
              child: itemCabecalho(
                  'Telefone: ' + customer.clienteTelefone.toString()),
            ),
          ]),
          SizedBox(height: 1),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Flexible(
              flex: 10,
              child: itemCabecalho(
                  'Endereço: ' + customer.clienteEndereco.toString()),
            ),
            Flexible(flex: 2, child: itemCabecalho('Nº: 110'))
          ]),
          SizedBox(height: 1),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Flexible(
                flex: 8,
                child: itemCabecalho(
                    'Bairro: ' + customer.clienteBairro.toString())),
            Flexible(
              flex: 11,
              child:
                  itemCabecalho('Cidade: ' + customer.clienteCidade.toString()),
            ),
          ]),
        ],
      ));

  static Widget itemCabecalho(String texto) {
    return Padding(
        padding: pw.EdgeInsets.all(.5),
        child: Container(
            alignment: Alignment.centerLeft,
            height: 15,
            decoration: BoxDecoration(
              border: Border.all(color: PdfColor(1, .5, .1), width: .5),
              borderRadius: BorderRadius.all(
                  Radius.circular(5.0) //         <--- border radius here
                  ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(texto,
                  textScaleFactor: .7,
                  style: TextStyle(color: PdfColor(.2, .2, .2))),
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
          SizedBox(height: 1 * PdfPageFormat.mm),
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
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          // Text(invoice.info.description),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(
      Invoice invoice, Uint8List imgCabeca2, Context context) {
    final headers = [
      'Qtd.',
      'Und',
      'Tipo',
      'Descrição',
      'Unitario',
      'Valor Total'
    ];
    final data = invoice.items.map((item) {
      final total = item.unitPrice! * item.quantity!.toInt();

      return [
        //   Utils.formatDate(item.date),
        '${item.quantity}',
        item.unidade,
        item.tipo,
        item.description,
        item.unitPrice != 0
            ? '${Utils.formatarValor(item.unitPrice!)}'
            : 'MATERIAL',
        total != 0 ? '${Utils.formatarValor(total)}' : 'MATERIAL',
      ];
    }).toList();

    return Container(
      alignment: Alignment.topLeft,
      //height: 15,
      decoration: BoxDecoration(
        border: Border.all(color: PdfColor(1, .5, .1), width: .5),
        borderRadius: BorderRadius.all(
            Radius.circular(5.0) //         <--- border radius here
            ),
      ),
      child: Table.fromTextArray(
        headers: headers,
        data: data,
        border: TableBorder(
          verticalInside: BorderSide(width: 1, color: PdfColor(1, .5, .1)),
        ),
        headerStyle: TextStyle(
            fontWeight: FontWeight.bold, color: PdfColors.white, fontSize: 8),
        headerDecoration: BoxDecoration(
          color: PdfColor(1, .6, .2),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              topLeft: Radius.circular(5) //         <--- border radius here
              ),
        ),
        cellHeight: 5,
        cellStyle: TextStyle(fontSize: 7),
        columnWidths: {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(6),
          3: FlexColumnWidth(14),
          4: FlexColumnWidth(4),
          5: FlexColumnWidth(5),
        },
        cellAlignments: {
          0: Alignment.centerLeft,
          1: Alignment.centerLeft,
          2: Alignment.centerLeft,
          3: Alignment.centerLeft,
          4: Alignment.centerLeft,
          5: Alignment.centerLeft,
        },
      ),
    );
  }

  static Widget buildTotal(Invoice invoice, bool pedid) {
    final netTotal = invoice.items
        .map((item) => item.unitPrice! * item.quantity!.toInt())
        .reduce((item1, item2) => item1 + item2);
    final total = netTotal;

    if (!pedid) {
      return Container(
        alignment: Alignment.topCenter,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 4,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.topLeft,
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                          color: PdfColor.fromHex('FDF0E7'),
                          border:
                              Border.all(color: PdfColor(1, .5, .1), width: .5),
                          borderRadius: BorderRadius.all(Radius.circular(
                                  5.0) //         <--- border radius here
                              ),
                        ),
                        child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                                'Observações: ${invoice.observacoesPedido}',
                                style: TextStyle(fontSize: 6))),
                      ),
                    ])),
            Spacer(flex: 2),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: PdfColor(1, .5, .1), width: .5),
                        borderRadius: BorderRadius.all(Radius.circular(
                                5.0) //         <--- border radius here
                            ),
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: buildText(
                            title: 'Total: ',
                            titleStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            value: Utils.formatarValor(total),
                            unite: true,
                          ))),
                  Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: PdfColor(1, .5, .1), width: .5),
                        borderRadius: BorderRadius.all(Radius.circular(
                                5.0) //         <--- border radius here
                            ),
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: buildText(
                            title: 'Cond. Pag.: ',
                            titleStyle: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            value: invoice.metPagamento,
                            unite: true,
                          )))
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  static Widget buildObsText(Invoice invoice) {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Container(
          alignment: Alignment.topLeft,
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            color: PdfColor.fromHex('FDF0E7'),
            border: Border.all(color: PdfColor(1, .5, .1), width: .5),
            borderRadius: BorderRadius.all(
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
        children: [Container(child: Image(MemoryImage(imagem)))],
      );
    } else
      return Text('');
  }

  static Widget buildFooter2(
      Invoice invoice, Uint8List imagem, Context context) {
    if (context.pagesCount == context.pageNumber) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              alignment: pw.Alignment.center,
              height: 250,
              child: Stack(alignment: Alignment.center, children: [
                Image(MemoryImage(imagem)),
                Align(
                    alignment: Alignment(.9, .097),
                    child: Text(invoice.prazoServico,
                        textScaleFactor: .55, textAlign: TextAlign.right)),
                Align(
                    alignment: Alignment(.9, -.05),
                    child: Text(invoice.metPagamento,
                        textScaleFactor: .55, textAlign: TextAlign.right)),
                Align(
                    alignment: Alignment(.9, -.2),
                    child: Text(Utils.formatarValor(invoice.valorTotal),
                        textScaleFactor: .55,
                        textAlign: TextAlign.right,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                Align(
                    alignment: Alignment(.9, -.75),
                    child: Container(
                      width: 180,
                      height: 25,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(invoice.customer!.name,
                                textScaleFactor: .8,
                                style:
                                    pw.TextStyle(color: PdfColor(.5, .5, .5))),
                            Text(invoice.customer!.doc,
                                textScaleFactor: .7,
                                style: pw.TextStyle(
                                    color: PdfColor(.5, .5, .5),
                                    fontWeight: FontWeight.bold)),
                          ]),
                    ))
              ]))
        ],
      );
    } else
      return Text('');
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
