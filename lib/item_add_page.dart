import 'package:flutter/material.dart';
import 'package:formulario_pdf/model/invoice.dart';

import 'api/pdf_api.dart';
import 'api/pdf_invoice_api.dart';
import 'model/customer.dart';
import 'model/supplier.dart';

List item = [];
var opcoes = [
  'Instalação',
  'Troca',
  'Limpeza',
  'Conserto',
  'Aferição',
  'Regulagem',
];

var tipoItem = [
  "Tomada",
  "Chuveiro",
  "Ar Condicionado",
  "Interruptor",
  "Compressor",
  "Bomba",
  "Quadro de Instalação",
  "Hidrante"
];

class ItemAddPage extends StatefulWidget {
  const ItemAddPage({Key? key}) : super(key: key);

  @override
  _ItemAddPageState createState() => _ItemAddPageState();
}

class _ItemAddPageState extends State<ItemAddPage> {
  Future<void> showMyDialog(BuildContext context) async {
    String dropdownValue = opcoes[1];
    final TextEditingController _controller1 = TextEditingController();
    final TextEditingController _controller2 = TextEditingController();

    return await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text('Add Item'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: opcoes.map((String opcoess) {
                      return DropdownMenuItem<String>(
                        value: opcoess,
                        child: Text(opcoess),
                      );
                    }).toList(),
                  ),
                  TextField(
                      controller: _controller1,
                      decoration: InputDecoration(
                        hintText: 'Quantidade',
                      )),
                  TextField(
                      controller: _controller2,
                      decoration: InputDecoration(
                        hintText: 'Preço',
                      )),
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
                    item.add(InvoiceItem(
                        description: dropdownValue,
                        date: DateTime.now(),
                        quantity: int.parse(_controller1.text),
                        vat: 1,
                        unitPrice: double.parse(_controller2.text)));
                    Navigator.of(context).pop();
                  },
                  child: Text('Add')),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Titulo'),
        ),
        body: Column(
          children: [
            Flexible(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: item.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Card(
                      child: ListTile(
                        title: Text(item[index].description),
                        subtitle: Text('Quantidade: ${item[index].quantity}'),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Color.fromRGBO(255, 100, 100, 1),
                          ),
                          onPressed: () {
                            item.removeAt(index);
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              onPressed: () async {
                await showMyDialog(context);
                setState(() {});
              },
              child: Icon(Icons.add),
            ),
            FloatingActionButton(
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
                  items: List.from(item),
                );

                final pdfFile = await PdfInvoiceApi.generate(invoice);

                PdfApi.openFile(pdfFile);
              },
              child: Icon(Icons.pages),
            ),
          ],
        ),
      ),
    );
  }
}
