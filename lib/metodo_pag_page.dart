import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:souza_autocenter/variaveis.dart';

import 'item_list_page.dart';
import 'resumo.dart';

List<String> condicaoPagamento = [
  "PIX",
  "SINAL DE 50%",
  "A VISTA",
  "DÉBITO",
  "CRÉDITO",
  "BOLETO",
  "CARTAO 2X",
  "CARTAO 3X",
  "CARTAO 4X",
  "CARTAO 5X",
  "CARTAO 6X",
  "CARTAO 7X",
  "CARTAO 8X",
  "CARTAO 9X",
  "CARTAO 10X",
  "CARTAO 11X",
  "CARTAO 12X",
  "A COMBINAR",
];

final txtControlPrazo = TextEditingController();

String? dropDownValue;

final txtControlObs = TextEditingController();

class CondPagamentoWidget extends StatefulWidget {
  final int indexOfItem;
  const CondPagamentoWidget({Key? key, required this.indexOfItem})
      : super(key: key);

  @override
  State<CondPagamentoWidget> createState() => _CondPagamentoWidgetState();
}

class _CondPagamentoWidgetState extends State<CondPagamentoWidget> {
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    txtControlPrazo.clear();
    txtControlObs.clear();
    dropDownValue = null;

    if (listaDeItens.invoices[widget.indexOfItem].metPagamento != '') {
      dropDownValue = listaDeItens.invoices[widget.indexOfItem].metPagamento;
    }
    if (listaDeItens.invoices[widget.indexOfItem].observacoesPedido != '') {
      txtControlObs.text =
          listaDeItens.invoices[widget.indexOfItem].observacoesPedido;
    }
    if (listaDeItens.invoices[widget.indexOfItem].prazoServico != '') {
      txtControlPrazo.text =
          listaDeItens.invoices[widget.indexOfItem].prazoServico;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        actions: const [],
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.red,
            size: 30,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 242, 241, 237),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () async {
          listaDeItens.invoices[widget.indexOfItem].metPagamento =
              dropDownValue!.toUpperCase();

          listaDeItens.invoices[widget.indexOfItem].observacoesPedido =
              txtControlObs.text;
          listaDeItens.invoices[widget.indexOfItem].prazoServico =
              txtControlPrazo.text;

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ItemListPage(
                        indexOfItem: widget.indexOfItem,
                      ))).then((value) => setState(() {}));
        },
        elevation: 8,
        child: const Icon(
          Icons.navigate_next,
          color: Colors.white,
          size: 50,
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 5, 10, 10),
                  child: Text(
                    '3 - INFORMAÇÕES ADICIONAIS',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 17,
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const Divider(color: Colors.red),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 17, 20, 5),
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15, 17, 8, 17),
                      filled: false,
                      fillColor: Colors.white,
                      labelText: 'Forma de Pagamento'),
                  value: dropDownValue,
                  onChanged: (String? value) {
                    setState(() {
                      dropDownValue = value.toString();
                    });
                  },
                  items: condicaoPagamento
                      .map((cityTitle) => DropdownMenuItem(
                          value: cityTitle, child: Text(cityTitle)))
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: TextFormField(
                  inputFormatters: [UpperCaseTextFormatter()],
                  controller: txtControlPrazo,
                  decoration: const InputDecoration(
                    filled: false,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.fromLTRB(15, 17, 8, 17),
                    labelText: 'Prazo de Execução',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: TextFormField(
                  inputFormatters: [UpperCaseTextFormatter()],
                  controller: txtControlObs,
                  obscureText: false,
                  decoration: const InputDecoration(
                    //contentPadding: EdgeInsets.fromLTRB(15, 17, 8, 17),
                    labelText: 'Observações Gerais',
                    filled: false,
                    fillColor: Colors.white,
                  ),
                  style: const TextStyle(),
                  maxLines: 9,
                  //maxLength: 500,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              const Divider(color: Colors.red),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'RESUMO',
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ResumoWidget(
                index: widget.indexOfItem,
              )
            ],
          )
        ],
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
