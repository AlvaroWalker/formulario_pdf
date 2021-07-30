//import '../components/resumo_widget.dart';
//import '../flutter_flow/flutter_flow_drop_down_template.dart';
//import '../flutter_flow/flutter_flow_theme.dart';
//import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:formulario_pdf/tela_itens_enviados.dart';
import 'package:formulario_pdf/variaveis.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

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

String? dropDownValue;

class CondPagamentoWidget extends StatefulWidget {
  int indexOfItem;
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
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ItemAddPage(
                        indexOfItem: widget.indexOfItem,
                      )));
        },
        //backgroundColor: Color(0xFFFF0000),
        elevation: 8,
        child: Icon(
          Icons.navigate_next,
          color: Colors.white,
          size: 24,
        ),
      ),
      body: SafeArea(
        child: Column(
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
              listaVazia: true,
            )
          ],
        ),
      ),
    );
  }
}
