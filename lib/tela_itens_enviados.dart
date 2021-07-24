import 'package:flutter/material.dart';

int? _radioValue = 0;

class TelaItensEnviados extends StatefulWidget {
  const TelaItensEnviados({Key? key}) : super(key: key);

  @override
  _TelaItensEnviadosState createState() => _TelaItensEnviadosState();
}

class _TelaItensEnviadosState extends State<TelaItensEnviados> {
  @override
  Widget orcamento() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Divider(
            indent: 20,
            endIndent: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 20,
            height: MediaQuery.of(context).size.height / 15,
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black26),
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Color.fromARGB(0, 0, 0, 0),
              shadowColor: Color.fromARGB(0, 0, 0, 0),
              child: Center(child: Text('TOTAL EM ORÇAMENTO: R\$ 15.190,00')),
            ),
          ),
          Divider(
            indent: 20,
            endIndent: 20,
          ),
        ],
      ),
    );
  }

  Widget pedido() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Divider(
            indent: 20,
            endIndent: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 20,
            height: MediaQuery.of(context).size.height / 15,
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black26),
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Color.fromARGB(0, 0, 0, 0),
              shadowColor: Color.fromARGB(0, 0, 0, 0),
              child: Center(child: Text('TOTAL EM PEDIDOS: R\$ 15.190,00')),
            ),
          ),
          Divider(
            indent: 20,
            endIndent: 20,
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Radio(
                  value: 0,
                  groupValue: _radioValue,
                  onChanged: (int? value) {
                    _radioValue = value;
                    setState(() {});
                  },
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'ORÇAMENTOS\nGERADOS',
                    maxLines: 2,
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                ),
                Radio(
                  value: 1,
                  groupValue: _radioValue,
                  onChanged: (int? value) {
                    _radioValue = value;
                    setState(() {});
                  },
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'PEDIDOS\nGERADOS',
                    maxLines: 2,
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                ),
              ],
            )),
        backgroundColor: Color.fromARGB(255, 210, 210, 210),
        body: AnimatedCrossFade(
          duration: const Duration(milliseconds: 250),
          firstChild: orcamento(),
          secondChild: pedido(),
          crossFadeState: _radioValue == 0
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        ));
  }
}
