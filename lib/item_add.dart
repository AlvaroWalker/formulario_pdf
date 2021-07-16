import 'package:flutter/material.dart';
import 'model/customer.dart';
import 'model/supplier.dart';
import 'model/invoice.dart';

List<String> tipoItem = [
  "Tomada",
  "Chuveiro",
  "Ar Condicionado",
  "Interruptor",
  "Compressor",
  "Bomba",
  "Quadro de Instalação",
  "Hidrante"
];

List<String> tipoServico = [
  "Instalação",
  "Troca",
  "Medição",
  "Conferencia",
];

List item = [
  InvoiceItem(
      description: 'description',
      date: DateTime.now(),
      quantity: 5,
      vat: 1,
      unitPrice: 32)
];
String _selectedValue = '';

class ItemAdd_Page extends StatefulWidget {
  final Customer cliente;
  const ItemAdd_Page({Key? key, required this.cliente}) : super(key: key);

  @override
  _ItemAdd_PageState createState() => _ItemAdd_PageState();
}

class _ItemAdd_PageState extends State<ItemAdd_Page> {
  @override
  Widget build(BuildContext context) {
    final txtControlPrecoUnidade = TextEditingController();
    final txtControlQuantidade = TextEditingController();

    var dropdownValue = tipoItem[0];
    var dropdownValue2 = tipoItem[0];
    final TextEditingController _controller = new TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 210, 210, 210),
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  labelText: "TIPO DE SERVIÇO",
                ),
                value: dropdownValue2,
                onChanged: (String? Value) {
                  setState(() {
                    //dropdownValue = Value;
                  });
                },
                items: tipoItem
                    .map((cityTitle) => DropdownMenuItem(
                        value: cityTitle, child: Text("$cityTitle")))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  labelText: 'DESCRIÇÃO DO SERVIÇO',
                ),
                value: dropdownValue,
                onChanged: (String? Value) {
                  setState(() {
                    //dropdownValue = Value;
                  });
                },
                items: tipoItem
                    .map((cityTitle) => DropdownMenuItem(
                        value: cityTitle, child: Text("$cityTitle")))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'R\$ ',
                    labelText: 'VALOR UNITARIO:',
                    border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'QUANTIDADE:',
                            border: OutlineInputBorder()),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(15),
                        ),
                        onPressed: () {
                          item.add(InvoiceItem(
                              description: dropdownValue,
                              date: DateTime.now(),
                              quantity: int.parse(txtControlQuantidade.text),
                              vat: 1,
                              unitPrice:
                                  double.parse(txtControlPrecoUnidade.text)));
                          //Navigator.of(context).pop();
                          setState(() {});
                        },
                        child: Icon(Icons.add)),
                  )
                ],
              ),
            ),
            Divider(),
            Text('RESUMO'),
            Card(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            return Text(item[index].quantity);
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              Text('a'),
                          itemCount: item.length),
                      Divider(),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Cliente: ${widget.cliente.name}'),
                              Text('CPF: ${widget.cliente.doc}'),
                            ],
                          ),
                          Expanded(
                            child: Text(
                              'R\$ 2.325,67',
                              textScaleFactor: 2,
                              textAlign: TextAlign.end,
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
