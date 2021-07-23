import 'package:flutter/material.dart';
import 'item_add_page.dart';
import 'model/customer.dart';
import 'model/supplier.dart';
import 'model/invoice.dart';

double valorTotal = 0;

List<String> descricaoServico = [
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

List itens = [];
String _selectedValue = '';

class ItemAdd_Page extends StatefulWidget {
  final Customer cliente;
  const ItemAdd_Page({Key? key, required this.cliente}) : super(key: key);

  @override
  _ItemAdd_PageState createState() => _ItemAdd_PageState();
}

class _ItemAdd_PageState extends State<ItemAdd_Page> {
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  String? dropdownValue;
  String? dropdownValue2;
  @override
  Widget build(BuildContext context) {
    final txtControlPrecoUnidade = TextEditingController();
    final txtControlQuantidade = TextEditingController();

    setState(() {});

    if (itens.length > 0) {
      valorTotal = itens
          .map((item) => item.unitPrice * item.quantity)
          .reduce((item1, item2) => item1 + item2);
    } else {
      valorTotal = 0;
    }

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
                  //filled: true,
                  labelText: "TIPO DE SERVIÇO",
                ),
                value: dropdownValue,
                onChanged: (value) {
                  dropdownValue = value.toString();
                  setState(() {});
                },
                items: tipoServico
                    .map((tipo) =>
                        DropdownMenuItem(value: tipo, child: Text("$tipo")))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  //filled: true,
                  labelText: 'DESCRIÇÃO DO SERVIÇO',
                ),
                value: dropdownValue2,
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue2 = value.toString();
                  });
                },
                items: descricaoServico
                    .map((cityTitle) => DropdownMenuItem(
                        value: cityTitle, child: Text("$cityTitle")))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: TextFormField(
                controller: txtControlPrecoUnidade,
                keyboardType: TextInputType.number,
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
                        controller: txtControlQuantidade,
                        keyboardType: TextInputType.number,
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
                          itens.add(InvoiceItem(
                              tipo: dropdownValue.toString(),
                              description: dropdownValue2.toString(),
                              date: DateTime.now(),
                              quantity: int.parse(txtControlQuantidade.text),
                              vat: 1,
                              unitPrice:
                                  double.parse(txtControlPrecoUnidade.text)));
                          setState(() {});
                        },
                        child: Icon(Icons.add)),
                  )
                ],
              ),
            ),
            Divider(),
            Text('RESUMO'),
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: InkWell(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ItemAddPage(
                                itensImport: itens,
                              )),
                    ).then((value) => setState(() {}));
                  },
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Table(
                          columnWidths: {0: FractionColumnWidth(.15)},
                          //border: TableBorder.all(),
                          children: [
                            for (var item in itens)
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(item.quantity.toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(item.tipo.toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(item.description.toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                        'R\$ ${(item.unitPrice * item.quantity).toStringAsFixed(2)}'),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child:
                                        Text('Cliente: ${widget.cliente.name}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text('CPF: ${widget.cliente.doc}'),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  'R\$ ${valorTotal.toStringAsFixed(2)}',
                                  textScaleFactor: 2,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
