import 'package:flutter/material.dart';

List<String> descricaoServico = [
  "A VISTA",
  "A PRAZO",
  "CARTAO 1X",
  "CARTAO 2X",
  "CARTAO 3X",
  "CARTAO 4X",
  "CARTAO 5X",
  "CARTAO 6X",
  "A COMBINAR",
];

class MetodoPagamentoPage extends StatefulWidget {
  const MetodoPagamentoPage({Key? key}) : super(key: key);

  @override
  _MetodoPagamentoPageState createState() => _MetodoPagamentoPageState();
}

String? dropdownValue2;

class _MetodoPagamentoPageState extends State<MetodoPagamentoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 210, 210, 210),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'METODO DE PAGAMENTO',
                  ),
                  value: dropdownValue2,
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue2 = value.toString();
                    });
                  },
                  items: descricaoServico
                      .map((cityTitle) => DropdownMenuItem(
                          value: cityTitle, child: Text("$cityTitle")))
                      .toList(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  //controller: txtControlDescricao,

                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(12, 23, 12, 22),
                      labelText: 'OBSERVAÇOES GERAIS',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            Divider(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
