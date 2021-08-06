import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formulario_pdf/model/supplier.dart';
import 'package:formulario_pdf/variaveis.dart';
import 'package:intl/intl.dart';

import 'model/customer.dart';

import 'item_add_page.dart';
import 'model/invoice.dart';

final txtControlCliente = TextEditingController();
final txtControlDoc = TextEditingController();
final txtControlInscEst = TextEditingController();
final txtControlRazaoSocial = TextEditingController();

final txtControlEnd = TextEditingController();
final txtControlBairro = TextEditingController();
final txtControlCidade = TextEditingController();
final txtControlTelefone = TextEditingController();

class TelaCliente extends StatefulWidget {
  final int id;
  final int indexOfId;
  final bool? editing;
  final Customer? clienteEdit;
  const TelaCliente(
      {Key? key,
      required this.id,
      this.editing,
      this.clienteEdit,
      required this.indexOfId})
      : super(key: key);

  @override
  _TelaClienteState createState() => _TelaClienteState();
}

class _TelaClienteState extends State<TelaCliente> {
  Widget build(BuildContext context) {
    int indexLista = widget.indexOfId;
    print(widget.indexOfId);
    if (listaDeItens.invoices.isNotEmpty) {
      indexLista = listaDeItens.invoices
          .indexWhere((Invoice element) => element.id == widget.id);
    }

    if (widget.clienteEdit != null) {
      txtControlCliente.text = widget.clienteEdit!.name;
      txtControlDoc.text = widget.clienteEdit!.doc;
      txtControlInscEst.text = widget.clienteEdit!.inscEst!;
      txtControlRazaoSocial.text = widget.clienteEdit!.razaoSocial!;

      txtControlEnd.text = widget.clienteEdit!.clienteEndereco!;
      txtControlBairro.text = widget.clienteEdit!.clienteBairro!;
      txtControlCidade.text = widget.clienteEdit!.clienteCidade!;
      txtControlTelefone.text = widget.clienteEdit!.clienteTelefone!;
    }
    caixaTexto(TextEditingController txtControl, String texto,
        TextInputType tipoTeclado, List<TextInputFormatter> formatadorTexto) {
      return Padding(
        padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
        child: TextFormField(
          inputFormatters: formatadorTexto,
          onChanged: (text) async {
            setState(() {
              print('teste');
            });
          },
          keyboardType: tipoTeclado,
          controller: txtControl,
          obscureText: false,
          decoration: InputDecoration(labelText: texto),
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
          caixaTexto(txtControlCliente, 'Cliente: ', TextInputType.name,
              [UpperCaseTextFormatter()]),
          caixaTexto(txtControlDoc, 'CPF/CNPJ: ', TextInputType.number,
              [FilteringTextInputFormatter.digitsOnly, CpfOuCnpjFormatter()]),
          caixaTexto(txtControlInscEst, 'INSC. EST.: ', TextInputType.number,
              [UpperCaseTextFormatter()]),
          caixaTexto(txtControlRazaoSocial, 'RAZÃO SOCIAL: ',
              TextInputType.text, [UpperCaseTextFormatter()]),
          Divider(
            height: 25,
            thickness: 1,
            indent: 25,
            endIndent: 25,
            //color: Color(0xFFFF7E00),
          ),
          caixaTexto(txtControlEnd, 'ENDEREÇO: ', TextInputType.text,
              [UpperCaseTextFormatter()]),
          caixaTexto(txtControlBairro, 'BAIRRO: ', TextInputType.text,
              [UpperCaseTextFormatter()]),
          caixaTexto(txtControlCidade, 'CIDADE: ', TextInputType.text,
              [UpperCaseTextFormatter()]),
          caixaTexto(txtControlTelefone, 'TELEFONE: ', TextInputType.phone, [
            FilteringTextInputFormatter.digitsOnly,
            TelefoneInputFormatter()
          ]),
        ],
      ),
      floatingActionButton: Visibility(
        visible: txtControlCliente.text.isNotEmpty,
        child: FloatingActionButton(
          elevation: 8,
          child: Icon(Icons.navigate_next),
          onPressed: () async {
            listaDeItens.invoices[indexLista].customer = Customer(
                name: txtControlCliente.text.toUpperCase(),
                doc: txtControlDoc.text,
                inscEst: txtControlInscEst.text,
                razaoSocial: txtControlRazaoSocial.text.toUpperCase(),
                clienteEndereco: txtControlEnd.text.toUpperCase(),
                clienteBairro: txtControlBairro.text.toUpperCase(),
                clienteCidade: txtControlCidade.text.toUpperCase(),
                clienteTelefone: txtControlTelefone.text);
            if (widget.editing == true) {
              Navigator.pop(context);
            } else {
              listaDeItens.invoices[indexLista].items = <InvoiceItem>[];
              listaDeItens.invoices[indexLista].supplier = Supplier(
                  name: 'name', address: 'address', paymentInfo: 'paymentInfo');
              listaDeItens.invoices[indexLista].info = InvoiceInfo(
                  description: 'description',
                  number: 'number',
                  date: DateFormat('dd-MM-yyyy')
                      .format(DateTime.now())
                      .toString(),
                  dueDate: 'dueDate');

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItemAddPage(id: widget.id)));
            }
          },
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
