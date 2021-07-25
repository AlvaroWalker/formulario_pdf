import 'package:flutter/material.dart';
import 'package:formulario_pdf/variaveis.dart';
import 'item_list_page.dart';
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

int? _radioValue = 0;
//List itens = [];
String _selectedValue = '';

class ItemAdd_Page extends StatefulWidget {
  final int id;
  const ItemAdd_Page({Key? key, required this.id}) : super(key: key);

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
    final txtControlDescricao = TextEditingController();

    setState(() {});
    int index = listaDeItens!.invoices
        .indexWhere((Invoice element) => element.id == widget.id);

    if (listaDeItens!.invoices[index].items.length != 0) {
      valorTotal = listaDeItens!.invoices[index].items
          .map((item) => item.unitPrice!.toDouble() * item.quantity!.toInt())
          .reduce((item1, item2) => item1 + item2);
    } else {
      valorTotal = 0;
    }

    Widget servico() {
      return Column(children: [
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
      ]);
    }

    Widget material() {
      return Column(children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: TextFormField(
            readOnly: true,
            enabled: false,

            //controller: txtControlQuantidade,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(12, 23, 12, 22),
                labelText: 'RELAÇÃO DE MATERIAL',
                border: OutlineInputBorder()),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: TextFormField(
            controller: txtControlDescricao,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(12, 23, 12, 22),
                labelText: 'DESCRIÇÃO DO MATERIAL',
                border: OutlineInputBorder()),
          ),
        ),
      ]);
    }

    final TextEditingController _controller = new TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Radio(
              value: 0,
              groupValue: _radioValue,
              onChanged: (int? value) {
                _radioValue = value;
                setState(() {});
              },
            ),
            Text(
              'SERVIÇO',
              style: TextStyle(color: Colors.black54),
            ),
            Radio(
              value: 1,
              groupValue: _radioValue,
              onChanged: (int? value) {
                _radioValue = value;
                setState(() {});
              },
            ),
            Text(
              'MATERIAIS',
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 210, 210, 210),
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 250),
              firstChild: servico(),
              secondChild: material(),
              crossFadeState: _radioValue == 0
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
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
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 3, left: 3),
                    child: TextFormField(
                      //controller: txtControlQuantidade,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'UNIDADE:', border: OutlineInputBorder()),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(15),
                        ),
                        onPressed: () async {
                          listaDeItens?.invoices[index].items.add(
                              new InvoiceItem(
                                  tipo: _radioValue == 0
                                      ? dropdownValue.toString()
                                      : 'Relação de Material',
                                  description: _radioValue == 0
                                      ? dropdownValue2.toString()
                                      : txtControlDescricao.text,
                                  date: DateTime.now().toString(),
                                  quantity:
                                      int.parse(txtControlQuantidade.text),
                                  unitPrice: double.parse(
                                      txtControlPrecoUnidade.text)));
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
                  side: BorderSide(color: Colors.black26),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: InkWell(
                  onTap: () async {
                    //print(listaDeItens?.invoices.length);

                    //print(listaDeItens?.toJson().toString());

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ItemAddPage(
                                indexOfItem: index,
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
                            for (var items
                                in listaDeItens!.invoices[index].items)
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Column(
                                      children: [
                                        Text(items.quantity.toString()),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(items.tipo.toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(items.description.toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text('R\$ ${(items.unitPrice)}'),
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
                                    padding:
                                        const EdgeInsets.only(top: 8, left: 8),
                                    child: Text(
                                        'Cliente: ${listaDeItens?.invoices[index].customer?.name}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8, left: 8),
                                    child: Text(
                                        'CPF: ${listaDeItens?.invoices[index].customer?.doc}'),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8, top: 8, right: 8),
                                child: Text(
                                    'R\$ ${valorTotal.toStringAsFixed(2)}',
                                    textScaleFactor: 2,
                                    textAlign: TextAlign.end,
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold)),
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
