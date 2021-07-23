import 'package:flutter/material.dart';
import 'package:formulario_pdf/model/invoice.dart';

import 'api/pdf_api.dart';
import 'api/pdf_invoice_api.dart';
import 'model/customer.dart';
import 'model/supplier.dart';
import 'utils.dart';

double valorTotal = 0;

List itens = [];

class ItemAddPage extends StatefulWidget {
  final List itensImport;
  ItemAddPage({Key? key, required this.itensImport}) : super(key: key);
  @override
  _ItemAddPageState createState() => _ItemAddPageState();
}

class _ItemAddPageState extends State<ItemAddPage> {
  void atualiza() {
    setState(() {});
  }

  Future<void> showMyDialog(
      BuildContext context, InvoiceItem item, int lsindex) async {
    InvoiceItem newitem = item;

    //String dropdownValue = opcoes[1];
    final TextEditingController _controller1 = TextEditingController();
    final TextEditingController _controller2 = TextEditingController();

    _controller1.text = item.quantity.toString();

    _controller2.text = item.unitPrice.toString();

    return await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(item.description),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
                        controller: _controller1,
                        decoration: InputDecoration(
                            labelText: 'Quantidade',
                            border: OutlineInputBorder())),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
                      controller: _controller2,
                      decoration: InputDecoration(
                          labelText: 'Preço', border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  onPressed: () {
                    widget.itensImport.replaceRange(lsindex, lsindex + 1, [
                      new InvoiceItem(
                          tipo: widget.itensImport[lsindex].tipo,
                          description: widget.itensImport[lsindex].description,
                          date: widget.itensImport[lsindex].date,
                          quantity: int.parse(_controller1.text),
                          vat: widget.itensImport[lsindex].vat,
                          unitPrice: double.parse(_controller2.text))
                    ]);
                    print(_controller1.text);
                    atualiza();
                    Navigator.of(context).pop();
                  },
                  child: Text('OK')),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itensImport.length > 0) {
      valorTotal = widget.itensImport
          .map((item) => item.unitPrice * item.quantity)
          .reduce((item1, item2) => item1 + item2);
    } else {
      valorTotal = 0;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 210, 210, 210),
      body: Column(
        children: [
          Text(
            'Total: R\$ ${valorTotal.toStringAsFixed(2)}',
            textScaleFactor: 2,
          ),
          Flexible(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: widget.itensImport.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: InkWell(
                      onTap: () async {
                        showMyDialog(context, widget.itensImport[index], index);
                        print(index);
                        setState(() {});
                      },
                      child: ListTile(
                        title: Text(widget.itensImport[index].description),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Quantidade: ${widget.itensImport[index].quantity}'),
                            Text(
                                'Preço Unitario: R\$ ${widget.itensImport[index].unitPrice}'),
                            Text(
                                'Preço Total: R\$ ${widget.itensImport[index].quantity * widget.itensImport[index].unitPrice}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Color.fromRGBO(255, 100, 100, 1),
                          ),
                          onPressed: () {
                            widget.itensImport.removeAt(index);
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                height: 2,
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            //backgroundColor: Colors.orange,
            onPressed: () async {
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
                  doc: 'endereço comp',
                ),
                info: InvoiceInfo(
                  date: date,
                  dueDate: dueDate,
                  description: 'descrição',
                  number: '${DateTime.now().year}/115',
                ),
                items: List.from(widget.itensImport),
              );

              final pdfFile = await PdfInvoiceApi.generate(invoice);

              PdfApi.openFile(pdfFile);
            },
            child: Icon(Icons.pages),
          ),
        ],
      ),
    );
  }
}
