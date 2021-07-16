import 'package:flutter/material.dart';

import 'item_add_page.dart';
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
                    style: TextStyle(color: Colors.deepOrange),
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
                    'PEDIDO AO CLIENTE',
                    style: TextStyle(color: Colors.deepOrange),
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
                    'RECIBO',
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
