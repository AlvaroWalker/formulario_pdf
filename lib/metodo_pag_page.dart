//import '../components/resumo_widget.dart';
//import '../flutter_flow/flutter_flow_drop_down_template.dart';
//import '../flutter_flow/flutter_flow_theme.dart';
//import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formulario_pdf/variaveis.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'item_list_page.dart';
import 'resumo.dart';

List<String> condicaoPagamento = [
  "A VISTA",
  "A PRAZO",
  "CARTAO 2X",
  "CARTAO 3X",
  "CARTAO 4X",
  "CARTAO 5X",
  "CARTAO 6X",
  "A COMBINAR",
];

final txtControlPrazo = TextEditingController();

String? dropDownValue;

class CondPagamentoWidget extends StatefulWidget {
  final int indexOfItem;
  CondPagamentoWidget({Key? key, required this.indexOfItem}) : super(key: key);

  @override
  _CondPagamentoWidgetState createState() => _CondPagamentoWidgetState();
}

class _CondPagamentoWidgetState extends State<CondPagamentoWidget> {
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0x00FF5600),
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFCDCDCD),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          listaDeItens.invoices[widget.indexOfItem].metPagamento =
              dropDownValue!.toUpperCase();

          listaDeItens.invoices[widget.indexOfItem].observacoesPedido =
              textController!.text;
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
        child: Icon(
          Icons.navigate_next,
          color: Colors.white,
          size: 24,
        ),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFFF7E00),
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                        //color: Color(0xFFFF7E00),
                        width: 1,
                      ),
                    ),
                    labelText: 'CONDIÇÃO DE PAGAMENTO',
                  ),
                  value: dropDownValue,
                  onChanged: (String? value) {
                    setState(() {
                      dropDownValue = value.toString();
                    });
                  },
                  items: condicaoPagamento
                      .map((cityTitle) => DropdownMenuItem(
                          value: cityTitle, child: Text("$cityTitle")))
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  inputFormatters: [UpperCaseTextFormatter()],
                  controller: txtControlPrazo,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(12, 23, 12, 22),
                    labelText: 'PRAZO DE EXECUÇÃO',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        //color: Color(0xFFFF7E00),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        //color: Color(0xFFFF7E00),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                        color: Color(0xFFFF7E00),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: TextFormField(
                  controller: textController,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'OBSERVAÇOES GERAIS',
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ),
                  maxLines: 10,
                  //maxLength: 10,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              Divider(
                height: 30,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              Align(
                alignment: Alignment(-0.7, 0),
                child: Text(
                  'RESUMO',
                  style: TextStyle(
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
