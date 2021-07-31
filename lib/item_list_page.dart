import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:formulario_pdf/model/invoice.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/pdf_api.dart';
import 'api/pdf_invoice_api.dart';
import 'variaveis.dart';

double valorTotal = 0;

bool criarPedido = false;

List itens = [];

class ItemAddPage extends StatefulWidget {
  final int indexOfItem;
  ItemAddPage({Key? key, required this.indexOfItem}) : super(key: key);
  @override
  _ItemAddPageState createState() => _ItemAddPageState();
}

class _ItemAddPageState extends State<ItemAddPage> {
  void atualiza() {
    setState(() {});
  }

  Future<void> showMyDialog(
      BuildContext context, InvoiceItem item, int lsindex) async {
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
                    listaDeItens.invoices[widget.indexOfItem].items
                        .replaceRange(lsindex, lsindex + 1, [
                      new InvoiceItem(
                          tipo: listaDeItens
                              .invoices[widget.indexOfItem].items[lsindex].tipo,
                          description: listaDeItens.invoices[widget.indexOfItem]
                              .items[lsindex].description,
                          unidade: listaDeItens.invoices[widget.indexOfItem]
                              .items[lsindex].unidade,
                          date: listaDeItens
                              .invoices[widget.indexOfItem].items[lsindex].date,
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
    if (listaDeItens.invoices[widget.indexOfItem].items.isNotEmpty) {
      valorTotal = listaDeItens.invoices[widget.indexOfItem].items
          .map((item) => item.unitPrice!.toDouble() * item.quantity!.toInt())
          .reduce((item1, item2) => item1 + item2);
    } else {
      valorTotal = 0;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'REVISE SEU PEDIDO',
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: Color.fromARGB(255, 210, 210, 210),
      body: Column(
        children: [
          Flexible(
            child: listaDeItens.invoices[widget.indexOfItem].items.isNotEmpty
                ? ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount:
                        listaDeItens.invoices[widget.indexOfItem].items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black26),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: InkWell(
                            onTap: () async {
                              showMyDialog(
                                  context,
                                  listaDeItens.invoices[widget.indexOfItem]
                                      .items[index],
                                  index);
                              //print(index);
                              setState(() {});
                            },
                            child: ListTile(
                              title: Text(listaDeItens
                                  .invoices[widget.indexOfItem]
                                  .items[index]
                                  .description
                                  .toString()),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Quantidade: ${listaDeItens.invoices[widget.indexOfItem].items[index].quantity}'),
                                  Text(
                                      'Preço Unitario: R\$ ${listaDeItens.invoices[widget.indexOfItem].items[index].unitPrice}'),
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
                                  listaDeItens
                                      .invoices[widget.indexOfItem].items
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
                  )
                : Container(),
          ),
          Text(
            'TOTAL ORÇADO: R\$ ${valorTotal.toStringAsFixed(2)}',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
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
                          Text(
                              'Cliente: ${listaDeItens.invoices[widget.indexOfItem].customer!.name}'),
                          Text(
                              'CPF/CNPJ: ${listaDeItens.invoices[widget.indexOfItem].customer!.doc}'),
                          Text(
                              'Insc. Estadual: ${listaDeItens.invoices[widget.indexOfItem].customer!.inscEst.toString()}'),
                          Text(
                              'Endereço: ${listaDeItens.invoices[widget.indexOfItem].customer!.clienteEndereco.toString()}'),
                          Text(
                              'Bairro: ${listaDeItens.invoices[widget.indexOfItem].customer!.clienteBairro.toString()}'),
                          Text(
                              'Cidade: ${listaDeItens.invoices[widget.indexOfItem].customer!.clienteCidade.toString()}'),
                          Text(
                              'Estado: ${listaDeItens.invoices[widget.indexOfItem].customer!.clienteEstado.toString()}'),
                          Text(
                              'Telefone: ${listaDeItens.invoices[widget.indexOfItem].customer!.clienteTelefone.toString()}'),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                  value: criarPedido,
                  onChanged: (value) {
                    setState(() {
                      criarPedido = !criarPedido;
                    });
                  }),
              Text('ANEXAR PEDIDO AO ORÇAMENTO')
            ],
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text('SALVAR E ENVIAR'),
        //backgroundColor: Colors.orange,
        onPressed: () async {
          listaDeItens.invoices[widget.indexOfItem].valorTotal = valorTotal;
          salvarPedido();

          final pdfFile = await PdfInvoiceApi.generate(
              listaDeItens.invoices[widget.indexOfItem]);

          PdfApi.openFile(pdfFile);
        },
      ),
    );
  }

  void salvarPedido() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //print(jsonEncode(listaDeItens!.toJson()));
    prefs.setString('teste1', jsonEncode(listaDeItens.toJson()));
  }
}
