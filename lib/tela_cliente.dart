import 'package:flutter/material.dart';

import 'model/customer.dart';

import 'item_add.dart';

class TelaCliente extends StatefulWidget {
  const TelaCliente({Key? key}) : super(key: key);

  @override
  _TelaClienteState createState() => _TelaClienteState();
}

class _TelaClienteState extends State<TelaCliente> {
  Widget build(BuildContext context) {
    final txtControlCliente = TextEditingController();
    final txtControlDoc = TextEditingController();
    final txtControl_insEst = TextEditingController();
    final txtControl_razaoSocial = TextEditingController();

    final txtControl_end = TextEditingController();
    final txtControl_bairro = TextEditingController();
    final txtControl_cidade = TextEditingController();
    final txtControl_telefone = TextEditingController();
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
          'ORÇAMENTO',
          style: TextStyle(color: Colors.black87),
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
              decoration: InputDecoration(
                  labelText: 'INSC. EST.:', border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
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
              decoration: InputDecoration(
                  labelText: 'ENDEREÇO:', border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'BAIRRO:', border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'CIDADE:', border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
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
            Customer clientes = new Customer(
                name: txtControlCliente.text, doc: txtControlDoc.text);
            print(txtControlCliente.text);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ItemAdd_Page(
                          cliente: clientes,
                        )));
          },
        ),
      ),
    );
  }
}
