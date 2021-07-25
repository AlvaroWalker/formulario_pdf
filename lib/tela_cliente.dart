import 'package:flutter/material.dart';
import 'package:formulario_pdf/model/supplier.dart';
import 'package:formulario_pdf/variaveis.dart';

import 'model/customer.dart';

import 'item_add_page.dart';
import 'model/invoice.dart';

class TelaCliente extends StatefulWidget {
  const TelaCliente({
    Key? key,
  }) : super(key: key);

  @override
  _TelaClienteState createState() => _TelaClienteState();
}

class _TelaClienteState extends State<TelaCliente> {
  Widget build(BuildContext context) {
    final txtControlCliente = TextEditingController();
    final txtControlDoc = TextEditingController();
    final txtControlInscEst = TextEditingController();
    final txtControlRazaoSocial = TextEditingController();

    final txtControlEnd = TextEditingController();
    final txtControlBairro = TextEditingController();
    final txtControlCidade = TextEditingController();
    final txtControlTelefone = TextEditingController();
    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      txtControlCliente.dispose();
      txtControlDoc.dispose();
      super.dispose();
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 210, 210, 210),
      appBar: AppBar(
        backgroundColor: Colors.transparent, // <-- APPBAR WITH TRANSPARENT BG
        elevation: 0, // <-- ELEVATION ZEROED
        title: Text(
          'INSIRA OS DADOS DO CLIENTE',
          style: TextStyle(color: Colors.black54),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        //fit: FlexFit.tight,
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              controller: txtControlCliente,
              decoration: InputDecoration(
                  labelText: 'Cliente:', border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              controller: txtControlDoc,
              decoration: InputDecoration(
                  labelText: 'CPF/CNPJ:', border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              controller: txtControlInscEst,
              decoration: InputDecoration(
                  labelText: 'INSC. EST.:', border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              controller: txtControlRazaoSocial,
              decoration: InputDecoration(
                  labelText: 'RAZÃO SOCIAL:', border: OutlineInputBorder()),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              controller: txtControlEnd,
              decoration: InputDecoration(
                  labelText: 'ENDEREÇO:', border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              controller: txtControlBairro,
              decoration: InputDecoration(
                  labelText: 'BAIRRO:', border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              controller: txtControlCidade,
              decoration: InputDecoration(
                  labelText: 'CIDADE:', border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              controller: txtControlTelefone,
              decoration: InputDecoration(
                  labelText: 'TELEFONE:', border: OutlineInputBorder()),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Visibility(
        //visible: MediaQuery.of(context).viewInsets.bottom == 0,
        child: FloatingActionButton(
          child: Icon(Icons.navigate_next),
          onPressed: () async {
            int index = listaDeItens!.invoices.length.toInt() - 1;

            listaDeItens?.invoices[index].customer = Customer(
                name: txtControlCliente.text,
                doc: txtControlDoc.text,
                inscEst: txtControlInscEst.text,
                razaoSocial: txtControlRazaoSocial.text,
                clienteEndereco: txtControlEnd.text,
                clienteBairro: txtControlBairro.text,
                clienteCidade: txtControlCidade.text,
                clienteTelefone: txtControlTelefone.text);

            listaDeItens?.invoices[index].items = <InvoiceItem>[];
            listaDeItens?.invoices[index].supplier = new Supplier(
                name: 'name', address: 'address', paymentInfo: 'paymentInfo');

            print(listaDeItens?.invoices[0].customer?.name);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ItemAdd_Page()));
          },
        ),
      ),
    );
  }
}
