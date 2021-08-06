import 'dart:convert';

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:formulario_pdf/gerando_pdf_pag.dart';
import 'package:formulario_pdf/model/invoice.dart';
import 'package:formulario_pdf/tela_cliente.dart';
import 'package:money2/money2.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'variaveis.dart';

final real = Currency.create('Real', 2,
    symbol: 'R\$', invertSeparators: true, pattern: 'S #.##0,00');

double valorTotal = 0;

bool criarPedido = false;

List itens = [];

double textSize = .8;

class ItemListPage extends StatefulWidget {
  final int indexOfItem;
  ItemListPage({Key? key, required this.indexOfItem}) : super(key: key);
  @override
  _ItemListPageState createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  void atualiza() {
    setState(() {});
  }

  Future<void> showMyDialog(
      BuildContext context, InvoiceItem item, int lsindex) async {
    //String dropdownValue = opcoes[1];
    final TextEditingController _controller1 = TextEditingController();
    final MoneyMaskedTextController _controller2 = MoneyMaskedTextController();

    _controller1.text = item.quantity.toString();

    _controller2.text = item.unitPrice.toString();

    return await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Column(
              children: [
                Text(item.tipo.toString()),
                Text(item.description.toString()),
              ],
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
                        controller: _controller1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Quantidade',
                            border: OutlineInputBorder())),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controller2,
                      decoration: InputDecoration(
                          prefixText: 'R\$ ',
                          labelText: 'Preço',
                          border: OutlineInputBorder()),
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
                          quantity: double.parse(_controller1.text),
                          unitPrice: _controller2.numberValue)
                    ]);
                    //print(_controller1.text);
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
          .map((item) => item.unitPrice!.toDouble() * item.quantity!.toDouble())
          .reduce((item1, item2) => item1 + item2);
    } else {
      valorTotal = 0;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'REVISE SEU ORÇAMENTO',
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
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(listaDeItens.invoices[widget.indexOfItem]
                                      .items[index].tipo
                                      .toString()),
                                  Text(listaDeItens.invoices[widget.indexOfItem]
                                      .items[index].description
                                      .toString()),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Quantidade: ${listaDeItens.invoices[widget.indexOfItem].items[index].quantity}'),
                                  Text(
                                    listaDeItens.invoices[widget.indexOfItem]
                                                .items[index].unitPrice! !=
                                            0
                                        ? Money.from(
                                                listaDeItens
                                                    .invoices[
                                                        widget.indexOfItem]
                                                    .items[index]
                                                    .unitPrice!
                                                    .toDouble(),
                                                real)
                                            .toString()
                                        : '',
                                  ),
                                  Text(listaDeItens.invoices[widget.indexOfItem]
                                              .items[index].unitPrice! !=
                                          0
                                      ? Money.from(
                                              listaDeItens
                                                      .invoices[
                                                          widget.indexOfItem]
                                                      .items[index]
                                                      .quantity! *
                                                  listaDeItens
                                                      .invoices[
                                                          widget.indexOfItem]
                                                      .items[index]
                                                      .unitPrice!
                                                      .toDouble(),
                                              real)
                                          .toString()
                                      : ''),
                                ],
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  //color: Colors.deepOrange,
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
            'TOTAL ORÇADO:  ${Money.from(valorTotal, real).toString()}',
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
                            'Cliente: ${listaDeItens.invoices[widget.indexOfItem].customer!.name}',
                            textScaleFactor: textSize,
                          ),
                          Text(
                            'CPF/CNPJ: ${listaDeItens.invoices[widget.indexOfItem].customer!.doc}',
                            textScaleFactor: textSize,
                          ),
                          Text(
                            'Insc. Estadual: ${listaDeItens.invoices[widget.indexOfItem].customer!.inscEst.toString()}',
                            textScaleFactor: textSize,
                          ),
                          Text(
                            'Endereço: ${listaDeItens.invoices[widget.indexOfItem].customer!.clienteEndereco.toString()}',
                            textScaleFactor: textSize,
                          ),
                          Text(
                            'Bairro: ${listaDeItens.invoices[widget.indexOfItem].customer!.clienteBairro.toString()}',
                            textScaleFactor: textSize,
                          ),
                          Text(
                            'Cidade: ${listaDeItens.invoices[widget.indexOfItem].customer!.clienteCidade.toString()}',
                            textScaleFactor: textSize,
                          ),
                          Text(
                            'Telefone: ${listaDeItens.invoices[widget.indexOfItem].customer!.clienteTelefone.toString()}',
                            textScaleFactor: textSize,
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TelaCliente(
                                            id: listaDeItens
                                                .invoices[widget.indexOfItem]
                                                .id,
                                            clienteEdit: listaDeItens
                                                .invoices[widget.indexOfItem]
                                                .customer,
                                            editing: true,
                                            indexOfId: widget.indexOfItem,
                                          ))).then((value) => null);
                            },
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
        onPressed: () async {
          listaDeItens.invoices[widget.indexOfItem].valorTotal = valorTotal;

          listaDeItens.invoices[widget.indexOfItem].pedido = criarPedido;
          salvarPedido();

          //PdfApi.openFile(pdfFile);
        },
      ),
    );
  }

  void salvarPedido() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print(jsonEncode(listaDeItens.toJson()));
    prefs.setString('teste1', jsonEncode(listaDeItens.toJson()));

    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PaginaGerandoPdf(index: widget.indexOfItem)))
        .then((value) => setState(() {}));
  }

  showWaitDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Gerando PDF'),
              ],
            ),
          ),
          actions: <Widget>[],
        );
      },
    );
  }
}
