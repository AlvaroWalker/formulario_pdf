import 'package:flutter/material.dart';
import 'package:formulario_pdf/model/supplier.dart';
import 'package:formulario_pdf/variaveis.dart';
import 'package:intl/intl.dart';

import 'model/customer.dart';

import 'item_add_page.dart';
import 'model/invoice.dart';

class TelaCliente extends StatefulWidget {
  final int id;
  const TelaCliente({Key? key, required this.id}) : super(key: key);

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

    caixaTexto(TextEditingController txt_control, String texto) {
      return Padding(
        padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
        child: TextFormField(
          controller: txt_control,
          obscureText: false,
          decoration: InputDecoration(
            labelText: texto,
            labelStyle: TextStyle(
              fontFamily: 'Poppins',
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFFF7E00),
                width: 1,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFFF7E00),
                width: 1,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
          textAlign: TextAlign.start,
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 210, 210, 210),
      appBar: AppBar(
        backgroundColor: Colors.transparent, // <-- APPBAR WITH TRANSPARENT BG
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        //fit: FlexFit.tight,
        children: [
          Align(
            alignment: Alignment(-1, 0),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(
                'INSIRA OS DADOS DO CLIENTE',
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          caixaTexto(txtControlCliente, 'Cliente: '),
          caixaTexto(txtControlDoc, 'CPF/CNPJ: '),
          caixaTexto(txtControlInscEst, 'INSC. EST.: '),
          caixaTexto(txtControlRazaoSocial, 'RAZÃO SOCIAL: '),
          Divider(
            height: 25,
            thickness: 1,
            indent: 25,
            endIndent: 25,
            //color: Color(0xFFFF7E00),
          ),
          caixaTexto(txtControlEnd, 'ENDEREÇO: '),
          caixaTexto(txtControlBairro, 'BAIRRO: '),
          caixaTexto(txtControlCidade, 'CIDADE: '),
          caixaTexto(txtControlTelefone, 'TELEFONE: '),
        ],
      ),
      floatingActionButton: Visibility(
        child: FloatingActionButton(
          elevation: 8,
          child: Icon(Icons.navigate_next),
          onPressed: () async {
            int index = listaDeItens!.invoices
                .indexWhere((Invoice element) => element.id == widget.id);

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
            listaDeItens?.invoices[index].supplier = Supplier(
                name: 'name', address: 'address', paymentInfo: 'paymentInfo');
            listaDeItens?.invoices[index].info = InvoiceInfo(
                description: 'description',
                number: 'number',
                date:
                    DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
                dueDate: 'dueDate');

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ItemAdd_Page(id: widget.id)));
          },
        ),
      ),
    );
  }
}
