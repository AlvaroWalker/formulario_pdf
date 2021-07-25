import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:formulario_pdf/model/invoice.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/pdf_api.dart';
import 'api/pdf_invoice_api.dart';
import 'model/customer.dart';
import 'model/supplier.dart';
import 'utils.dart';
import 'variaveis.dart';

double valorTotal = 0;

List itens = [];

class ItemAddPage extends StatefulWidget {
  ItemAddPage({
    Key? key,
  }) : super(key: key);
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
            title: Text(item.description.toString()),
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
                    listaDeItens!.invoices[0].items
                        .replaceRange(lsindex, lsindex + 1, [
                      new InvoiceItem(
                          tipo: listaDeItens!.invoices[0].items[lsindex].tipo,
                          description: listaDeItens!
                              .invoices[0].items[lsindex].description,
                          date: listaDeItens!.invoices[0].items[lsindex].date,
                          quantity: int.parse(_controller1.text),
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
    int indexo = listaDeItens!.invoices.length.toInt() - 1;
    if (listaDeItens?.invoices[indexo].items.length != null) {
      //valorTotal = widget.lista.items!.map((item) => item.unitPrice * item.quantity).reduce((item1, item2) => item1 + item2);
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
          Flexible(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: listaDeItens!.invoices[0].items.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: InkWell(
                      onTap: () async {
                        showMyDialog(context,
                            listaDeItens!.invoices[indexo].items[0], index);
                        //print(index);
                        setState(() {});
                      },
                      child: ListTile(
                        title: Text(listaDeItens!
                            .invoices[indexo].items[index].description
                            .toString()),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Quantidade: ${listaDeItens!.invoices[indexo].items[index].quantity}'),
                            Text(
                                'Preço Unitario: R\$ ${listaDeItens!.invoices[indexo].items[index].unitPrice}'),
                            // Text(
                            //      'Preço Total: R\$ ${widget.lista.items?[index].quantity * widget.lista.items[index].unitPrice}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.deepOrange,
                          ),
                          onPressed: () {
                            listaDeItens!.invoices[indexo].items
                                .removeAt(index);
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
          Text(
            'Total: R\$ ${valorTotal.toStringAsFixed(2)}',
            textScaleFactor: 2,
          ),
          Flexible(
              child: Container(
            width: MediaQuery.of(context).size.width - 16,
            height: MediaQuery.of(context).size.height / 4,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /*
                          Text('Cliente: ${widget.lista.items.customer.name}'),
                          Text('CPF/CNPJ: ${widget.cliente.doc}'),
                          Text(
                              'Insc. Estadual: ${widget.cliente.inscEst.toString()}'),
                          Text(
                              'Endereço: ${widget.cliente.clienteEndereco.toString()}'),
                          Text(
                              'Bairro: ${widget.cliente.clienteBairro.toString()}'),
                          Text(
                              'Cidade: ${widget.cliente.clienteCidade.toString()}'),
                          Text(
                              'Estado: ${widget.cliente.clienteEstado.toString()}'),
                          Text(
                              'Telefone: ${widget.cliente.clienteTelefone.toString()}'),*/
                        ],
                      ),
                    ),
                    Flexible(
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.mode_edit_outline_outlined)))
                  ],
                ),
              ),
            ),
          )),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            //backgroundColor: Colors.orange,
            onPressed: () {
              salvarPedido();

              //final pdfFile = await PdfInvoiceApi.generate(invoice);

              //PdfApi.openFile(pdfFile);
            },
            child: Icon(Icons.pages),
          ),
        ],
      ),
    );
  }

  void salvarPedido() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final date = DateTime.now();
    final dueDate = date.add(Duration(days: 7));

    final invoice = Invoice(
      id: 1,
      supplier: Supplier(
        name: 'vendedor',
        address: 'endereço',
        paymentInfo: 'blabla',
      ),
      customer: Customer(
        name: 'widget.lista.items.customer.name',
        doc: 'widget.lista.items.customer.doc',
      ),
      info: InvoiceInfo(
        date: date.toString(),
        dueDate: dueDate.toString(),
        description: 'descrição',
        number: '${DateTime.now().year}/115',
      ),
      items: listaDeItens!.invoices[0].items,
    );
    print(jsonEncode(invoice.toJson()));
    //prefs.setString('valores', jsonEncode(invoice.toJson()));
  }
}
