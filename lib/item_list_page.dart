import 'package:flutter/material.dart';
import 'package:formulario_pdf/model/invoice.dart';

import 'api/pdf_api.dart';
import 'api/pdf_invoice_api.dart';
import 'model/customer.dart';
import 'model/supplier.dart';
import 'utils.dart';

double valorTotal = 0;

bool criarPedido = true;

List itens = [];

class ItemAddPage extends StatefulWidget {
  final List itensImport;

  final Customer cliente;
  ItemAddPage({Key? key, required this.itensImport, required this.cliente})
      : super(key: key);
  @override
  _ItemAddPageState createState() => _ItemAddPageState();
}

class _ItemAddPageState extends State<ItemAddPage> {
  void atualiza() {
    setState(() {});
  }

  void initState() {
    super.initState();
    criarPedido = true;
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
            title: Text(item.description),
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
                    widget.itensImport.replaceRange(lsindex, lsindex + 1, [
                      new InvoiceItem(
                          tipo: widget.itensImport[lsindex].tipo,
                          description: widget.itensImport[lsindex].description,
                          date: widget.itensImport[lsindex].date,
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
    if (widget.itensImport.length > 0) {
      valorTotal = widget.itensImport
          .map((item) => item.unitPrice * item.quantity)
          .reduce((item1, item2) => item1 + item2);
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
              itemCount: widget.itensImport.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: InkWell(
                      onTap: () async {
                        showMyDialog(context, widget.itensImport[index], index);
                        //print(index);
                        setState(() {});
                      },
                      child: ListTile(
                        title: Text(widget.itensImport[index].description),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Quantidade: ${widget.itensImport[index].quantity}'),
                            Text(
                                'Preço Unitario: R\$ ${widget.itensImport[index].unitPrice}'),
                            Text(
                                'Preço Total: R\$ ${widget.itensImport[index].quantity * widget.itensImport[index].unitPrice}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.deepOrange,
                          ),
                          onPressed: () {
                            widget.itensImport.removeAt(index);
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
                          Text('Cliente: ${widget.cliente.name}'),
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
                              'Telefone: ${widget.cliente.clienteTelefone.toString()}'),
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
<<<<<<< Updated upstream
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            //backgroundColor: Colors.orange,
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
                  name: widget.cliente.name,
                  doc: widget.cliente.doc,
=======
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              listaDeItens.invoices[widget.indexOfItem].pedido == false ||
                      abriuPedido == false
                  ? Checkbox(
                      value: criarPedido,
                      onChanged: (value) {
                        setState(() {
                          criarPedido = !criarPedido;
                          botaoPedido = criarPedido;
                          print(botaoPedido);
                        });
                      })
                  : Text(''),
              listaDeItens.invoices[widget.indexOfItem].pedido == false ||
                      abriuPedido == false
                  ? Text('ANEXAR PEDIDO AO ORÇAMENTO')
                  : Text(''),
            ],
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text('SALVAR E ENVIAR'),
        onPressed: () async {
          print('Apertou orcamento: $abriuOrcamento');
          botaoPedido = criarPedido;
          listaDeItens.invoices[widget.indexOfItem].valorTotal = valorTotal;

          if (listaDeItens.invoices[widget.indexOfItem].pedido == true) {
            // jaUmPedido = true;
          }

          if (listaDeItens.invoices[widget.indexOfItem].pedido == false) {
            listaDeItens.invoices[widget.indexOfItem].pedido = criarPedido;
          }

          salvarPedido(jaUmPedido);

          //PdfApi.openFile(pdfFile);
        },
      ),
    );
  }

  void salvarPedido(bool ped) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print(jsonEncode(listaDeItens.toJson()));
    await prefs.setString('teste1', jsonEncode(listaDeItens.toJson()));

    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PaginaGerandoPdf(index: widget.indexOfItem, jaPedido: ped)))
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

  listaItensWidget() {
    return listaDeItens.invoices[widget.indexOfItem].items.isNotEmpty
        ? ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: listaDeItens.invoices[widget.indexOfItem].items.length,
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
                          listaDeItens
                              .invoices[widget.indexOfItem].items[index],
                          index);
                      //print(index);
                      setState(() {});
                    },
                    child: ListTile(
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(listaDeItens
                              .invoices[widget.indexOfItem].items[index].tipo
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
                                            .invoices[widget.indexOfItem]
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
                                      listaDeItens.invoices[widget.indexOfItem]
                                              .items[index].quantity! *
                                          listaDeItens
                                              .invoices[widget.indexOfItem]
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
                          color: Palette.primary,
                        ),
                        onPressed: () {
                          listaDeItens.invoices[widget.indexOfItem].items
                              .removeAt(index);
                          setState(() {});
                        },
                      ),
                    ),
                  ),
>>>>>>> Stashed changes
                ),
                info: InvoiceInfo(
                  date: date,
                  dueDate: dueDate,
                  description: 'descrição',
                  number: '${DateTime.now().year}/115',
                ),
                items: List.from(widget.itensImport),
              );

              final pdfFile = await PdfInvoiceApi.generate(invoice);

              PdfApi.openFile(pdfFile);
            },
            child: Icon(Icons.pages),
          ),
        ],
      ),
    );
  }
}
