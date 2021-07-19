import 'package:flutter/material.dart';
import 'package:formulario_pdf/api/pdf_api.dart';
import 'package:formulario_pdf/api/pdf_invoice_api.dart';
import 'package:formulario_pdf/main.dart';
import 'package:formulario_pdf/model/customer.dart';
import 'package:formulario_pdf/model/invoice.dart';
import 'package:formulario_pdf/model/supplier.dart';
import 'package:formulario_pdf/widget/button_widget.dart';
import 'package:formulario_pdf/widget/title_widget.dart';

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(MyApp.title),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TitleWidget(
                  icon: Icons.picture_as_pdf,
                  text: 'gerar pdf',
                ),
                const SizedBox(height: 48),
                ButtonWidget(
                  text: 'PDF',
                  onClicked: () async {
                    final date = DateTime.now();
                    final dueDate = date.add(Duration(days: 7));

                    final invoice = Invoice(
                      supplier: Supplier(
                        name: 'vendedor',
                        address: 'endereço',
                        paymentInfo: 'blabla',
                      ),
                      customer: Customer(
                        name: 'comprador',
                        doc: 'documento',
                      ),
                      info: InvoiceInfo(
                        date: date,
                        dueDate: dueDate,
                        description: 'descrição',
                        number: '${DateTime.now().year}/115',
                      ),
                      items: [
                        InvoiceItem(
                          tipo: '2',
                          description: 'café',
                          date: DateTime.now(),
                          quantity: 3,
                          vat: 0.0,
                          unitPrice: 10,
                        ),
                        InvoiceItem(
                          tipo: '2',
                          description: 'agua',
                          date: DateTime.now(),
                          quantity: 8,
                          vat: 0.0,
                          unitPrice: 2,
                        ),
                        InvoiceItem(
                          tipo: '2',
                          description: 'arroz',
                          date: DateTime.now(),
                          quantity: 10,
                          vat: 0.0,
                          unitPrice: 25,
                        ),
                      ],
                    );

                    final pdfFile = await PdfInvoiceApi.generate(invoice);

                    PdfApi.openFile(pdfFile);
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
