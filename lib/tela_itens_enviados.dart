import 'package:flutter/material.dart';

int? _radioValue = 0;

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

    listaDeItens.invoices.forEach((element) {
      if (element.orcamento == true) {
        listaOrcamento.invoices.add(element);
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
              child: Center(child: Text('TOTAL EM ORÇAMENTO: R\$ 15.190,00')),
            ),
          ),
          Divider(
            indent: 20,
            endIndent: 20,
          ),
<<<<<<< Updated upstream
=======
          Flexible(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: listaOrcamento.invoices.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: InkWell(
                      onTap: () async {
                        abriuOrcamento = true;

                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemAddPage(
                                      id: listaDeItens.invoices.indexWhere(
                                          (Invoice element) =>
                                              element.id ==
                                              listaOrcamento
                                                  .invoices[index].id),
                                      orcamentoEditar: listaDeItens.invoices[
                                          listaDeItens.invoices.indexWhere(
                                              (Invoice element) =>
                                                  element.id ==
                                                  listaOrcamento
                                                      .invoices[index].id)],
                                    )));
                        setState(() {});
                      },
                      child: ListTile(
                        title: Text(
                            'Cliente: ${listaOrcamento.invoices[index].customer?.name}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Data: ${listaOrcamento.invoices[index].info?.date}'),
                            Text(
                                'Valor Total: ${Utils.formatarValor(listaOrcamento.invoices[index].valorTotal)}'),
                            // Text(
                            //      'Preço Total: R\$ ${widget.lista.items?[index].quantity * widget.lista.items[index].unitPrice}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Palette.primary,
                          ),
                          onPressed: () {
                            listaDeItens
                                .invoices[listaDeItens.invoices.indexWhere(
                                    (element) =>
                                        element.id ==
                                        listaOrcamento.invoices[index].id)]
                                .orcamento = false;

                            //listaOrcamento.invoices.removeAt(index);

                            if (listaDeItens.invoices[index].orcamento ==
                                    false &&
                                listaDeItens.invoices[index].pedido == false) {
                              listaDeItens.invoices.removeAt(
                                  listaDeItens.invoices.indexWhere((element) =>
                                      element.id ==
                                      listaOrcamento.invoices[index].id));
                            }

                            listaOrcamento.invoices.clear();
                            listaDeItens.invoices.forEach((element) {
                              if (element.orcamento == true) {
                                listaOrcamento.invoices.add(element);
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
>>>>>>> Stashed changes
        ],
      ),
    );
  }

  Widget pedido() {
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
              child: Center(child: Text('TOTAL EM PEDIDOS: R\$ 15.190,00')),
            ),
          ),
          Divider(
            indent: 20,
            endIndent: 20,
          ),
<<<<<<< Updated upstream
=======
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
                        abriuPedido = true;
                        print(abriuPedido);

                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemAddPage(
                                      id: listaDeItens.invoices.indexWhere(
                                          (Invoice element) =>
                                              element.id ==
                                              listaPedidos.invoices[index].id),
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
                            color: Palette.primary,
                          ),
                          onPressed: () {
                            /*
                            listaDeItens.invoices.removeAt(listaDeItens.invoices
                                .indexWhere((Invoice element) =>
                                    element.id ==
                                    listaPedidos.invoices[index].id));

                            listaPedidos.invoices.removeAt(index);

                            
*/
                            listaDeItens
                                .invoices[listaDeItens.invoices.indexWhere(
                                    (element) =>
                                        element.id ==
                                        listaPedidos.invoices[index].id)]
                                .pedido = false;

                            if (listaDeItens.invoices[index].orcamento ==
                                    false &&
                                listaDeItens.invoices[index].pedido == false) {
                              listaDeItens.invoices.removeAt(
                                  listaDeItens.invoices.indexWhere((element) =>
                                      element.id ==
                                      listaPedidos.invoices[index].id));
                            }

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
>>>>>>> Stashed changes
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
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
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'ORÇAMENTOS\nGERADOS',
                    maxLines: 2,
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                ),
                Radio(
                  value: 1,
                  groupValue: _radioValue,
                  onChanged: (int? value) {
                    _radioValue = value;
                    setState(() {});
                  },
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'PEDIDOS\nGERADOS',
                    maxLines: 2,
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                ),
              ],
<<<<<<< Updated upstream
            )),
        backgroundColor: Color.fromARGB(255, 210, 210, 210),
        body: AnimatedCrossFade(
          duration: const Duration(milliseconds: 250),
          firstChild: orcamento(),
          secondChild: pedido(),
          crossFadeState: _radioValue == 0
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        ));
=======
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
>>>>>>> Stashed changes
  }
}
