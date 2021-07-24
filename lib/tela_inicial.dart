import 'package:flutter/material.dart';
import 'package:formulario_pdf/tela_itens_enviados.dart';

import 'item_list_page.dart';
import 'tela_cliente.dart';

class TelaInicio extends StatelessWidget {
  const TelaInicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      // <-- STACK AS THE SCAFFOLD PARENT
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/imagens/telalaranja.jpg'), // <-- BACKGROUND IMAGE
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor:
              Colors.transparent, // <-- SCAFFOLD WITH TRANSPARENT BG
          appBar: AppBar(
            title: Text(''),
            backgroundColor:
                Colors.transparent, // <-- APPBAR WITH TRANSPARENT BG
            elevation: 0, // <-- ELEVATION ZEROED
          ),
          body: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 75,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/imagens/logo.png'), // <-- BACKGROUND IMAGE
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      onPrimary: Colors.black87,
                      primary: Colors.white,
                      shape: StadiumBorder(),
                      minimumSize: Size(80, 50)),
                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TelaCliente()));
                  },
                  child: Text(
                    'ORÇAMENTO',
                    style: TextStyle(color: Colors.deepOrange, fontSize: 30),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      onPrimary: Colors.black87,
                      primary: Colors.white,
                      shape: StadiumBorder(),
                      minimumSize: Size(80, 50)),
                  onPressed: () {},
                  child: Text(
                    'PEDIDO',
                    style: TextStyle(color: Colors.deepOrange, fontSize: 30),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 3,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      //onPrimary: Colors.black87,
                      primary: Colors.white,
                      shape: StadiumBorder(),
                      minimumSize: Size(80, 50)),
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaItensEnviados()));
                  },
                  child: Text(
                    'MEUS ENVIOS',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
