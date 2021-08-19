import 'dart:io';
import 'package:formulario_pdf/api/pdf_api.dart';
import 'package:formulario_pdf/model/customer.dart';
import 'package:formulario_pdf/model/invoice.dart';
import 'package:formulario_pdf/model/supplier.dart';
import 'package:formulario_pdf/utils.dart';
<<<<<<< Updated upstream
=======
import 'package:formulario_pdf/variaveis.dart';
import 'package:intl/intl.dart';
>>>>>>> Stashed changes
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();
<<<<<<< Updated upstream
=======
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
    if (jaUmPedido == false) {
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
    }

    if (invoice.pedido && botaoPedido) {
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
    if (invoice.orcamento == false && invoice.pedido == true && botaoPedido ||
        abriuPedido == true) {
      return PdfApi.saveDocument(
        nomePdf: invoice.customer!.name,
        name: 'pdf_gerado2.pdf',
        pdf: pdf2,
      );
    } else {
      return PdfApi.saveDocument(
          nomePdf: invoice.customer!.name,
          name: 'pdf_gerado.pdf',
          name2: 'pdf_gerado2.pdf',
          pdf: pdf,
          pdf2: pdf2);
    }
  }

  static Future<File> generateOnlyPedido(
      Invoice invoice, bool jaUmPedido) async {
    final pdf2 = Document();

    final imagemFundo = (await rootBundle.load('assets/orcamentoPag1.jpg'))
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
>>>>>>> Stashed changes

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(invoice),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(invoice),
        buildInvoice(invoice),
        Divider(),
        buildTotal(invoice),
      ],
      footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(name: 'pdf_gerado.pdf', pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSupplierAddress(invoice.supplier),
              Container(
                height: 50,
                width: 50,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: invoice.info.number,
                ),
              ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCustomerAddress(invoice.customer),
              buildInvoiceInfo(invoice.info),
            ],
          ),
        ],
      );

  static Widget buildCustomerAddress(Customer customer) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(customer.name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(customer.doc),
        ],
      );

  static Widget buildInvoiceInfo(InvoiceInfo info) {
    final paymentTerms = '${info.dueDate.difference(info.date).inDays} dias';
    final titles = <String>['cod:', 'data:', 'pagamento:', 'validade:'];
    final data = <String>[
      info.number,
      Utils.formatDate(info.date),
      paymentTerms,
      Utils.formatDate(info.dueDate),
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
          Text(invoice.info.description),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(Invoice invoice) {
    final headers = ['descriçaõ', 'data', 'quantidade', 'unitario', 'total'];
    final data = invoice.items.map((item) {
      final total = item.unitPrice * item.quantity;

      return [
        item.description,
        Utils.formatDate(item.date),
        '${item.quantity}',
        'R\$ ${item.unitPrice}',
        'R\$ ${total.toStringAsFixed(2)}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(Invoice invoice) {
    final netTotal = invoice.items
        .map((item) => item.unitPrice * item.quantity)
        .reduce((item1, item2) => item1 + item2);
    final total = netTotal;

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
<<<<<<< Updated upstream
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'prec liqud',
                  value: Utils.formatPrice(netTotal),
                  unite: true,
                ),
                Divider(),
                buildText(
                  title: 'Total',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: Utils.formatPrice(total),
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
=======
          Container(
              height: 200,
              child: Stack(alignment: Alignment.center, children: [
                Image(MemoryImage(imagem)),
              ]))
>>>>>>> Stashed changes
        ],
      ),
    );
  }

  static Widget buildFooter(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
<<<<<<< Updated upstream
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(
              title: 'endereço', value: invoice.supplier.address.toString()),
          SizedBox(height: 1 * PdfPageFormat.mm),
          buildSimpleText(
              title: 'met pagamento',
              value: invoice.supplier.paymentInfo.toString()),
=======
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
>>>>>>> Stashed changes
        ],
      );

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
