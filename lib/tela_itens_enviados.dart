import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:souza_autocenter/model/invoicelist.dart';
import 'package:souza_autocenter/theme/custom_theme.dart';
import 'package:souza_autocenter/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'item_add_page.dart';
import 'variaveis.dart';

InvoiceList listaPedidos = InvoiceList(invoices: []);

InvoiceList listaOrcamento = InvoiceList(invoices: []);

class TelaItensEnviados extends StatefulWidget {
  const TelaItensEnviados({Key? key}) : super(key: key);

  @override
  State<TelaItensEnviados> createState() => _TelaItensEnviadosState();
}

class _TelaItensEnviadosState extends State<TelaItensEnviados> {
  @override
  void initState() {
    super.initState();
    for (var element in listaDeItens.invoices) {
      if (element.pedido == true) {
        listaPedidos.invoices.add(element);
      }
    }

    for (var element in listaDeItens.invoices) {
      if (element.orcamento == true) {
        listaOrcamento.invoices.add(element);
      }
    }
  }

  Widget orcamento() {
    listaOrcamento.invoices.clear();
    for (var element in listaDeItens.invoices) {
      if (element.orcamento == true) {
        listaOrcamento.invoices.add(element);
      }
    }
    listaOrcamento.invoices = listaOrcamento.invoices.reversed.toList();
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          const Divider(
            indent: 20,
            endIndent: 20,
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width - 20,
            height: MediaQuery.sizeOf(context).height / 15,
            child: Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black26),
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: const Color.fromARGB(0, 0, 0, 0),
              shadowColor: const Color.fromARGB(0, 0, 0, 0),
              child: Center(
                  child: Text(listaOrcamento.invoices.isNotEmpty
                      ? 'TOTAL EM ORÇAMENTOS: ${Utils.formatarValor(listaOrcamento.invoices.map((item) => item.valorTotal.toDouble()).reduce((item1, item2) => item1 + item2))}'
                      : 'NENHUM ORÇAMENTO REGISTRADO')),
            ),
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
          ),
          Flexible(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: listaOrcamento.invoices.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black26),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: InkWell(
                    onTap: () async {
                      abriuOrcamento = true;

                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ItemAddPage(
                                    id: listaOrcamento.invoices[index].id,
                                    orcamentoEditar: listaDeItens.invoices[
                                        listaDeItens.invoices.indexWhere(
                                            (element) =>
                                                element.id ==
                                                listaOrcamento
                                                    .invoices[index].id)],
                                  )));
                      setState(() {});
                    },
                    child: ListTile(
                      contentPadding: const EdgeInsets.only(
                          left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
                      title: Text(
                          'Cliente: ${listaOrcamento.invoices[index].customer?.name}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Veículo: ${listaOrcamento.invoices[index].customer?.veiculo}'),
                          Text(
                              'Data: ${listaOrcamento.invoices[index].info?.date}'),
                          Text(
                              'Valor Total: ${Utils.formatarValor(listaOrcamento.invoices[index].valorTotal)}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                              abriuOrcamento = true;

                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ItemAddPage(
                                            id: listaOrcamento
                                                .invoices[index].id,
                                            orcamentoEditar:
                                                listaDeItens.invoices[
                                                    listaDeItens.invoices
                                                        .indexWhere((element) =>
                                                            element.id ==
                                                            listaOrcamento
                                                                .invoices[index]
                                                                .id)],
                                          )));
                              setState(() {});
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      title: const Text('Apagar Orçamento?'),
                                      content: const Text(
                                          'Deseja apagar este Orçamento?'),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Não'),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  listaDeItens
                                                      .invoices[listaDeItens
                                                          .invoices
                                                          .indexWhere(
                                                              (element) =>
                                                                  element.id ==
                                                                  listaOrcamento
                                                                      .invoices[
                                                                          index]
                                                                      .id)]
                                                      .orcamento = false;

                                                  if (listaDeItens
                                                              .invoices[index]
                                                              .orcamento ==
                                                          false &&
                                                      listaDeItens
                                                              .invoices[index]
                                                              .pedido ==
                                                          false) {
                                                    listaDeItens.invoices
                                                        .removeAt(listaDeItens
                                                            .invoices
                                                            .indexWhere((element) =>
                                                                element.id ==
                                                                listaOrcamento
                                                                    .invoices[
                                                                        index]
                                                                    .id));
                                                  }

                                                  listaOrcamento.invoices
                                                      .clear();
                                                  for (var element
                                                      in listaDeItens
                                                          .invoices) {
                                                    if (element.orcamento ==
                                                        true) {
                                                      listaOrcamento.invoices
                                                          .add(element);
                                                    }
                                                  }

                                                  Navigator.pop(context);
                                                  setState(() {});
                                                },
                                                child: const Text('Sim'))
                                          ],
                                        ),
                                      ],
                                    );
                                  });

                              setState(() {
                                salvarPedido();
                              });
                            },
                          ),
                        ],
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
    for (var element in listaDeItens.invoices) {
      if (element.pedido == true) {
        listaPedidos.invoices.add(element);
      }
    }
    listaPedidos.invoices = listaPedidos.invoices.reversed.toList();
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          const Divider(
            indent: 20,
            endIndent: 20,
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width - 20,
            height: MediaQuery.sizeOf(context).height / 15,
            child: Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black26),
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: const Color.fromARGB(0, 0, 0, 0),
              shadowColor: const Color.fromARGB(0, 0, 0, 0),
              child: Center(
                  child: Text(listaPedidos.invoices.isNotEmpty
                      ? 'TOTAL EM PEDIDOS: ${Utils.formatarValor(listaPedidos.invoices.map((item) => item.valorTotal.toDouble()).reduce((item1, item2) => item1 + item2))}'
                      : 'NENHUM PEDIDO REGISTRADO')),
            ),
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
          ),
          Flexible(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: listaPedidos.invoices.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black26),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: InkWell(
                    onTap: () async {
                      abriuPedido = true;

                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ItemAddPage(
                                    id: listaPedidos.invoices[index].id,
                                    orcamentoEditar: listaDeItens.invoices[
                                        listaDeItens.invoices.indexWhere(
                                            (element) =>
                                                element.id ==
                                                listaPedidos
                                                    .invoices[index].id)],
                                  )));
                      setState(() {});
                    },
                    child: ListTile(
                      contentPadding: const EdgeInsets.only(
                          left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
                      title: Text(
                          'Cliente: ${listaPedidos.invoices[index].customer?.name}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Veículo: ${listaPedidos.invoices[index].customer?.veiculo}'),
                          Text(
                              'Data: ${listaPedidos.invoices[index].info?.date}'),
                          Text(
                              'Valor Total: ${Utils.formatarValor(listaPedidos.invoices[index].valorTotal)}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                              abriuOrcamento = true;

                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ItemAddPage(
                                            id: listaOrcamento
                                                .invoices[index].id,
                                            orcamentoEditar:
                                                listaDeItens.invoices[
                                                    listaDeItens.invoices
                                                        .indexWhere((element) =>
                                                            element.id ==
                                                            listaPedidos
                                                                .invoices[index]
                                                                .id)],
                                          )));
                              setState(() {});
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      title: const Text('Apagar Pedido?'),
                                      content: const Text(
                                          'Deseja excluir este Pedido?'),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Não')),
                                            TextButton(
                                                onPressed: () {
                                                  listaDeItens
                                                      .invoices[listaDeItens
                                                          .invoices
                                                          .indexWhere(
                                                              (element) =>
                                                                  element.id ==
                                                                  listaPedidos
                                                                      .invoices[
                                                                          index]
                                                                      .id)]
                                                      .pedido = false;

                                                  if (listaDeItens
                                                              .invoices[index]
                                                              .orcamento ==
                                                          false &&
                                                      listaDeItens
                                                              .invoices[index]
                                                              .pedido ==
                                                          false) {
                                                    listaDeItens.invoices
                                                        .removeAt(listaDeItens
                                                            .invoices
                                                            .indexWhere((element) =>
                                                                element.id ==
                                                                listaPedidos
                                                                    .invoices[
                                                                        index]
                                                                    .id));
                                                  }

                                                  listaPedidos.invoices.clear();
                                                  for (var element
                                                      in listaDeItens
                                                          .invoices) {
                                                    if (element.pedido ==
                                                        true) {
                                                      listaPedidos.invoices
                                                          .add(element);
                                                    }
                                                  }
                                                  Navigator.pop(context);
                                                  setState(() {});
                                                },
                                                child: const Text('Sim'))
                                          ],
                                        ),
                                      ],
                                    );
                                  });

                              setState(() {
                                salvarPedido();
                              });
                            },
                          ),
                        ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 241, 237),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            foregroundColor: CustomTheme.lightTheme.colorScheme.secondary,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: Navigator.of(context).pop,
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.red,
                size: 30,
              ),
            ),
            bottom: TabBar(
              indicatorColor: Colors.red,
              labelColor: CustomTheme.lightTheme.colorScheme.secondary,
              tabs: const [
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

    prefs.setString('teste1', jsonEncode(listaDeItens.toJson()));
  }
}
