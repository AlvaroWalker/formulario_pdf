import 'package:flutter/material.dart';
import 'package:formulario_pdf/tela_itens_enviados.dart';

import 'item_list_page.dart';
import 'tela_cliente.dart';

class TelaInicio extends StatelessWidget {
  const TelaInicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      // <-- STACK AS THE SCAFFOLD PARENT
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/imagens/telalaranja.jpg'), // <-- BACKGROUND IMAGE
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor:
              Colors.transparent, // <-- SCAFFOLD WITH TRANSPARENT BG
          appBar: AppBar(
            title: Text(''),
            backgroundColor:
                Colors.transparent, // <-- APPBAR WITH TRANSPARENT BG
            elevation: 0, // <-- ELEVATION ZEROED
          ),
          body: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 75,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/imagens/logo.png'), // <-- BACKGROUND IMAGE
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      onPrimary: Colors.black87,
                      primary: Colors.white,
                      shape: StadiumBorder(),
                      minimumSize: Size(80, 50)),
                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TelaCliente()));
                  },
                  child: Text(
                    'ORÇAMENTO',
                    style: TextStyle(color: Colors.deepOrange, fontSize: 30),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      onPrimary: Colors.black87,
                      primary: Colors.white,
                      shape: StadiumBorder(),
                      minimumSize: Size(80, 50)),
                  onPressed: () {},
                  child: Text(
                    'PEDIDO',
                    style: TextStyle(color: Colors.deepOrange, fontSize: 30),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 3,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      //onPrimary: Colors.black87,
                      primary: Colors.white,
                      shape: StadiumBorder(),
                      minimumSize: Size(80, 50)),
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaItensEnviados()));
                  },
                  child: Text(
                    'MEUS ENVIOS',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
<<<<<<< Updated upstream
=======

  botaoOrcamento() async {}

  botaoPedido() async {}

  botoesMenu() {
    return AnimationLimiter(
        child: AnimationLimiter(
            child: AnimationConfiguration.staggeredList(
                position: 1,
                child: SlideAnimation(
                    delay: Duration(milliseconds: 500),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              height: 200,
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 4,
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width * .6, 55),
                                onPrimary: Colors.black87,
                                primary: Color.fromARGB(255, 255, 255, 255),
                                shape: StadiumBorder(),
                              ),
                              onPressed: () async {
                                int indexOfId = 0;
                                novoId = 0;
                                if (listaDeItens.invoices.isEmpty) {
                                  listaDeItens = InvoiceList(invoices: []);
                                }

                                while (listaDeItens.invoices.any(
                                    (Invoice element) =>
                                        element.id == novoId)) {
                                  novoId++;

                                  //  print(idRepetido);
                                  //idRepetido = true;
                                }

                                listaDeItens.invoices.add(Invoice(
                                    id: novoId, items: <InvoiceItem>[]));

                                indexOfId = listaDeItens.invoices.indexWhere(
                                    (Invoice element) => element.id == novoId);

                                //print(indexOfId.toString() + novoId.toString());

                                idNovoPedido = indexOfId;

                                listaDeItens.invoices.removeWhere((element) =>
                                    element.customer?.name == null &&
                                    element.id != novoId);

                                listaDeItens.invoices.forEach((element) {
                                  //print(element.id);
                                });
                                abriuOrcamento = false;
                                abriuPedido = false;

                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TelaCliente(
                                              id: novoId,
                                              editing: false,
                                              indexOfIdd: indexOfId,
                                            )));
                              },
                              child: Text(
                                'ORÇAMENTO',
                                style: TextStyle(
                                    //color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 4,
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width * .6,
                                      55),
                                  onPrimary: Colors.black87,
                                  primary: Color.fromARGB(255, 255, 255, 255),
                                  shape: StadiumBorder(),
                                  minimumSize: Size(80, 50)),
                              onPressed: () {
                                int indexOfId = 0;
                                novoId = 0;
                                if (listaDeItens.invoices.isEmpty) {
                                  listaDeItens = InvoiceList(invoices: []);
                                }

                                while (listaDeItens.invoices.any(
                                    (Invoice element) =>
                                        element.id == novoId)) {
                                  novoId++;

                                  //   print(idRepetido);
                                  idRepetido = true;
                                }

                                listaDeItens.invoices.add(Invoice(
                                    id: novoId,
                                    orcamento: false,
                                    pedido: true,
                                    items: <InvoiceItem>[]));

                                indexOfId = listaDeItens.invoices.indexWhere(
                                    (Invoice element) => element.id == novoId);

                                //    print(indexOfId.toString() + novoId.toString());

                                idNovoPedido = indexOfId;

                                //  print(listaDeItens.invoices
                                //      .indexWhere((Invoice element) => element.id == novoId));

                                listaDeItens.invoices.removeWhere((element) =>
                                    element.customer?.name == null &&
                                    element.id != novoId);
                                abriuOrcamento = false;
                                abriuPedido = true;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TelaCliente(
                                            id: novoId,
                                            editing: false,
                                            indexOfIdd: listaDeItens.invoices
                                                .indexWhere((Invoice element) =>
                                                    element.id == novoId))));
                              },
                              child: Text(
                                'PEDIDO',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Divider(
                              thickness: 3,
                              color: Colors.transparent,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  //elevation: 4,
                                  shadowColor: Colors.transparent,
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width * .6,
                                      55),

                                  //onPrimary: Colors.black87,
                                  primary: Color.fromARGB(0, 0, 0, 0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(
                                          color: Colors.white, width: 2)),
                                  minimumSize: Size(80, 50)),
                              onPressed: () async {
                                if (listaDeItens.invoices.isEmpty) {
                                  listaDeItens = InvoiceList(invoices: []);
                                }
                                listaDeItens.invoices.removeWhere((element) =>
                                    element.customer?.name == null);

                                listaDeItens.invoices.removeWhere((element) =>
                                    element.orcamento == false &&
                                    element.pedido == false);

                                //listaDeItens.invoices.clear();

                                abriuOrcamento = false;
                                abriuPedido = false;

                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TelaItensEnviados()));
                              },
                              child: Text(
                                'MEUS ENVIOS',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )))));
  }
>>>>>>> Stashed changes
}
