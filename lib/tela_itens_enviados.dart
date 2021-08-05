import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:formulario_pdf/model/invoicelist.dart';
import 'package:formulario_pdf/theme/custom_theme.dart';
import 'package:formulario_pdf/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'item_add_page.dart';
import 'model/invoice.dart';
import 'variaveis.dart';

InvoiceList listaPedidos = InvoiceList(invoices: []);

class TelaItensEnviados extends StatefulWidget {
  const TelaItensEnviados({Key? key}) : super(key: key);

  @override
  _TelaItensEnviadosState createState() => _TelaItensEnviadosState();
}

class _TelaItensEnviadosState extends State<TelaItensEnviados> {
  void initState() {
    super.initState();
    listaDeItens.invoices.forEach((element) {
      if (element.pedido == true) {
        listaPedidos.invoices.add(element);
      }
    });
  }

  Widget orcamento() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Divider(
            indent: 20,
            endIndent: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 20,
            height: MediaQuery.of(context).size.height / 15,
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black26),
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Color.fromARGB(0, 0, 0, 0),
              shadowColor: Color.fromARGB(0, 0, 0, 0),
              child: Center(
                  child: Text(listaDeItens.invoices.length != 0
                      ? 'TOTAL EM ORÇAMENTOS: ${Utils.formatarValor(listaDeItens.invoices.map((item) => item.valorTotal.toDouble()).reduce((item1, item2) => item1 + item2))}'
                      : 'NENHUM ORÇAMENTO REGISTRADO')),
            ),
          ),
          Divider(
            indent: 20,
            endIndent: 20,
          ),
          Flexible(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: listaDeItens.invoices.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: InkWell(
                      onTap: () async {
                        pdfVisualizado = false;
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemAddPage(
                                      id: listaDeItens.invoices.indexWhere(
                                          (Invoice element) =>
                                              element.id ==
                                              listaDeItens.invoices[index].id),
                                      orcamentoEditar:
                                          listaDeItens.invoices[index],
                                    )));
                        setState(() {});
                      },
                      child: ListTile(
                        title: Text(
                            'Cliente: ${listaDeItens.invoices[index].customer?.name}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Data: ${listaDeItens.invoices[index].info?.date}'),
                            Text(
                                'Valor Total: ${Utils.formatarValor(listaDeItens.invoices[index].valorTotal)}'),
                            // Text(
                            //      'Preço Total: R\$ ${widget.lista.items?[index].quantity * widget.lista.items[index].unitPrice}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            //color: Colors.deepOrange,
                          ),
                          onPressed: () {
                            listaDeItens.invoices.removeAt(index);
                            listaPedidos.invoices.clear();
                            listaDeItens.invoices.forEach((element) {
                              if (element.pedido == true) {
                                listaPedidos.invoices.add(element);
                              }
                            });

                            salvarPedido();
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
          )
        ],
      ),
    );
  }

  Widget pedido() {
    listaPedidos.invoices.clear();
    listaDeItens.invoices.forEach((element) {
      if (element.pedido == true) {
        listaPedidos.invoices.add(element);
      }
    });
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Divider(
            indent: 20,
            endIndent: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 20,
            height: MediaQuery.of(context).size.height / 15,
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black26),
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Color.fromARGB(0, 0, 0, 0),
              shadowColor: Color.fromARGB(0, 0, 0, 0),
              child: Center(
                  child: Text(listaPedidos.invoices.length != 0
                      ? 'TOTAL EM PEDIDOS: ${Utils.formatarValor(listaPedidos.invoices.map((item) => item.valorTotal.toDouble()).reduce((item1, item2) => item1 + item2))}'
                      : 'NENHUM PEDIDO REGISTRADO')),
            ),
          ),
          Divider(
            indent: 20,
            endIndent: 20,
          ),
          Flexible(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: listaPedidos.invoices.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: InkWell(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemAddPage(
                                      id: listaDeItens.invoices.indexWhere(
                                          (Invoice element) =>
                                              element.id ==
                                              listaDeItens.invoices[index].id),
                                      orcamentoEditar:
                                          listaDeItens.invoices[index],
                                    )));
                        setState(() {});
                      },
                      child: ListTile(
                        title: Text(
                            'Cliente: ${listaPedidos.invoices[index].customer?.name}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Data: ${listaPedidos.invoices[index].info?.date}'),
                            Text(
                                'Valor Total: ${Utils.formatarValor(listaPedidos.invoices[index].valorTotal)}'),
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
                            listaDeItens.invoices.removeAt(listaDeItens.invoices
                                .indexWhere((Invoice element) =>
                                    element.id ==
                                    listaPedidos.invoices[index].id));

                            listaPedidos.invoices.removeAt(index);

                            listaPedidos.invoices.clear();
                            listaDeItens.invoices.forEach((element) {
                              if (element.pedido == true) {
                                listaPedidos.invoices.add(element);
                              }
                            });

                            setState(() {
                              salvarPedido();
                            });
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
          )
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 210, 210, 210),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            foregroundColor: CustomTheme.lightTheme.accentColor,
            elevation: 0,
            backgroundColor: Colors.transparent,
            bottom: TabBar(
              indicatorColor: CustomTheme.lightTheme.accentColor,
              labelColor: CustomTheme.lightTheme.accentColor,
              tabs: [
                Tab(
                  text: 'ORÇAMENTOS',
                ),
                Tab(
                  text: 'PEDIDOS',
                ),
              ],
            ),
            title: const Text(''),
          ),
          body: TabBarView(
            children: [
              orcamento(),
              pedido(),
            ],
          ),
        ),
      ),
    );
  }

  void salvarPedido() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //print(jsonEncode(listaDeItens!.toJson()));
    prefs.setString('teste1', jsonEncode(listaDeItens.toJson()));

    //showWaitDialog();

    //final pdfFile =
    //    await PdfInvoiceApi.generate(listaDeItens.invoices[widget.indexOfItem]);

    //PdfApi.openFile(pdfFile);
  }
}
  

/*
AnimatedCrossFade(
          duration: const Duration(milliseconds: 250),
          firstChild: orcamento(),
          secondChild: pedido(),
          crossFadeState: _radioValue == 0
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        )*/