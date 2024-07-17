import 'package:brasil_fields/brasil_fields.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:souza_autocenter/model/supplier.dart';
import 'package:souza_autocenter/variaveis.dart';
import 'package:intl/intl.dart';

import 'model/customer.dart';

import 'item_add_page.dart';
import 'model/invoice.dart';

final txtControlCliente = TextEditingController();
final txtControlDoc = TextEditingController();
final tctControlVeiculo = TextEditingController();
final txtControlRazaoSocial = TextEditingController();

final txtControlEnd = TextEditingController();
final txtControlBairro = TextEditingController();
final txtControlCidade = TextEditingController();
final txtControlTelefone = TextEditingController();

class TelaCliente extends StatefulWidget {
  final int id;
  final int indexOfIdd;
  final bool? editing;
  final Customer? clienteEdit;
  const TelaCliente(
      {Key? key,
      required this.id,
      this.editing = false,
      this.clienteEdit,
      required this.indexOfIdd})
      : super(key: key);

  @override
  State<TelaCliente> createState() => _TelaClienteState();
}

class _TelaClienteState extends State<TelaCliente> {
  @override
  void initState() {
    super.initState();

    txtControlCliente.clear();
    txtControlDoc.clear();
    tctControlVeiculo.clear();
    txtControlRazaoSocial.clear();

    txtControlEnd.clear();
    txtControlBairro.clear();
    txtControlCidade.clear();
    txtControlTelefone.clear();

    if (widget.clienteEdit != null && widget.editing == true) {
      txtControlCliente.text = widget.clienteEdit!.name;
      txtControlDoc.text = widget.clienteEdit!.doc;
      tctControlVeiculo.text = widget.clienteEdit!.veiculo!;
      txtControlRazaoSocial.text = widget.clienteEdit!.razaoSocial!;

      txtControlEnd.text = widget.clienteEdit!.clienteEndereco!;
      txtControlBairro.text = widget.clienteEdit!.clienteBairro!;
      txtControlCidade.text = widget.clienteEdit!.clienteCidade!;
      txtControlTelefone.text = widget.clienteEdit!.clienteTelefone!;
    }
  }

  @override
  Widget build(BuildContext context) {
    caixaTexto(TextEditingController txtControl, String texto,
        TextInputType tipoTeclado, List<TextInputFormatter> formatadorTexto) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
        child: TextFormField(
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          inputFormatters: formatadorTexto,
          onChanged: (text) {
            setState(() {});
          },
          keyboardType: tipoTeclado,
          controller: txtControl,
          obscureText: false,
          decoration: InputDecoration(labelText: texto),
          style: const TextStyle(
            fontFamily: 'Poppins',
          ),
          textAlign: TextAlign.start,
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 241, 237),
      appBar: AppBar(
        backgroundColor: Colors.transparent, // <-- APPBAR WITH TRANSPARENT BG
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.red,
            size: 30,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(2.5),
        //fit: FlexFit.tight,
        children: [
          const Align(
            alignment: Alignment(-1, 0),
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 10, 20),
              child: Text(
                '1 - INSIRA OS DADOS DO CLIENTE',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 17,
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          caixaTexto(txtControlCliente, 'Cliente: ', TextInputType.name,
              [UpperCaseTextFormatter()]),
          caixaTexto(tctControlVeiculo, 'Veículo: ', TextInputType.text,
              [UpperCaseTextFormatter()]),
          caixaTexto(txtControlTelefone, 'Telefone: ', TextInputType.phone, [
            FilteringTextInputFormatter.digitsOnly,
            TelefoneInputFormatter()
          ]),
          const Divider(
            height: 25,
            thickness: 1,
            indent: 25,
            endIndent: 25,
            color: Colors.red,
          ),
          ExpandChild(
              expandIndicatorStyle: ExpandIndicatorStyle.both,
              indicatorExpandedHint: 'mostrar menos',
              indicatorCollapsedHint: 'mostrar mais',
              child: Column(
                children: [
                  caixaTexto(
                      txtControlDoc, 'CPF/CNPJ: ', TextInputType.number, [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfOuCnpjFormatter()
                  ]),
                  caixaTexto(txtControlRazaoSocial, 'Razão Social: ',
                      TextInputType.text, [UpperCaseTextFormatter()]),
                  caixaTexto(txtControlEnd, 'Endereço: ', TextInputType.text,
                      [UpperCaseTextFormatter()]),
                  caixaTexto(txtControlBairro, 'Bairro: ', TextInputType.text,
                      [UpperCaseTextFormatter()]),
                  caixaTexto(txtControlCidade, 'Cidade UF: ',
                      TextInputType.text, [UpperCaseTextFormatter()]),
                ],
              )),
        ],
      ),
      floatingActionButton: Visibility(
        visible: txtControlCliente.text.isNotEmpty,
        child: FloatingActionButton(
          elevation: 8,
          child: const Icon(
            Icons.navigate_next,
            color: Colors.white,
            size: 50,
          ),
          onPressed: () {
            listaDeItens.invoices[widget.indexOfIdd].customer = Customer(
                name: txtControlCliente.text,
                doc: txtControlDoc.text,
                veiculo: tctControlVeiculo.text,
                razaoSocial: txtControlRazaoSocial.text,
                clienteEndereco: txtControlEnd.text,
                clienteBairro: txtControlBairro.text,
                clienteCidade: txtControlCidade.text,
                clienteTelefone: txtControlTelefone.text);
            if (widget.editing == true) {
              Navigator.pop(context);
            } else if (widget.editing == false) {
              listaDeItens.invoices[widget.indexOfIdd].items = <InvoiceItem>[];
              listaDeItens.invoices[widget.indexOfIdd].supplier = Supplier(
                  name: 'name', address: 'address', paymentInfo: 'paymentInfo');
              listaDeItens.invoices[widget.indexOfIdd].info = InvoiceInfo(
                  description: 'description',
                  number: 'number',
                  date: DateFormat('dd-MM-yyyy')
                      .format(DateTime.now())
                      .toString(),
                  dueDate: 'dueDate');

              Navigator.pop(context);

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
