import 'package:flutter/material.dart';
import 'item_list_page.dart';
import 'model/customer.dart';
import 'model/supplier.dart';
import 'model/invoice.dart';

double valorTotal = 0;

List<String> descricaoServico = [
<<<<<<< Updated upstream
  "Tomada",
  "Chuveiro",
  "Ar Condicionado",
  "Interruptor",
  "Compressor",
  "Bomba",
  "Quadro de Instalação",
  "Hidrante"
=======
  "AR CONDICIONADO",
  "ATERRAMENTO",
  "AUMENTO DE CARGA",
  "BOMBA DE POÇO",
  "BOMBA HIDRÁULICA",
  "BOMBA SAPO",
  "CABEAMENTO",
  "CAIXA DE PADRÃO",
  "CAIXA DE PASSAGEM",
  "CANALETA",
  "CANELINHA",
  "CHAVE",
  "CHUVEIRO ",
  "CLIMATIZADOR ",
  "COMPRESSOR",
  "COMPRESSOR",
  "CONTATORA",
  "CONTROLADORA",
  "CORRENTE",
  "DISJUNTOR",
  "ELETRO CALHA",
  "ELETRODUTO",
  "EQUIPAMENTOS",
  "EXAUSTOR",
  "FUSÍVEIS",
  "GEORREFENCIADO ",
  "HASTES",
  "HIDRANTE",
  "HIDRANTE",
  "INTERFONE",
  "INTERRUPTOR 3 TECLAS",
  "INTERRUPTOR COM TOMADA",
  "INTERRUPTOR DUPLO COM TOMADA",
  "INSTALAÇÃO DE PADRÃO",
  "INSTALAÇÃO DE PADRÃO BI-FASE",
  "INSTALAÇÃO DE PADRÃO MONO",
  "INSTALAÇÃO DE PADRÃO TRI-FASE",
  "INSTALAÇÃO DE QUADRO DE DISTRIBUIÇÃO",
  "INSTALAÇÃO EQUIPAMENTOS",
  "LAMPADA DE POSTE",
  "LOCAL",
  "LUMINÁRIA DE EMBUTIR",
  "LUMINÁRIA DE EMBUTIR",
  "LUMINÁRIA DE EMERGÊNCIA",
  "LUMINÁRIA DE SOBREPOR",
  "LUMINÁRIA DICRÓICA",
  "LUMINÁRIA",
  "LUMINÁRIA",
  "MÁQUINA",
  "MOTOR",
  "PADRÃO ",
  "PAINEL DE COMANDO",
  "PAINEL",
  "PARA-RAIOS",
  "PORTÃO ELETRÔNICO",
  "POSTE CONCRETO 10m",
  "POSTE CONCRETO 11m",
  "POSTE CONCRETO 6m",
  "POSTE CONCRETO 7m",
  "POSTE CONCRETO 8m",
  "POSTE CONCRETO 9m",
  "POSTE DE PADRÃO COM CAIXA",
  "PROJETO ELÉTROTÉCNICO",
  "PROJETO TÉCNICO",
  "PROJETOR",
  "QUADRO DE COMANDO",
  "QUADRO DE DISTRIBUIÇÃO",
  "QUADRO DE DISTRIBUIÇÃO INDIVIDUAL",
  "QUADRO DE MEDIÇÃO AGRUPADO",
  "REATOR DE POSTE",
  "REDE ALTA TENSÃO",
  "REDE BIFÁSICA",
  "REDE DE INTERNET",
  "REDE MONOFÁSICA",
  "REDE SEM FIO",
  "REDE TRIFÁSICA",
  "REFLETOR",
  "RELÉ CÍCLICO",
  "RELÉ DE TEMPO",
  "RELÉ FALTA DE FASE",
  "RELÉ FOTO CÉLULA",
  "RELÉ",
  "ROTEADOR",
  "SIRENE",
  "SPDA",
  "SUPER-POSTE",
  "TENSÃO",
  "TERMINAIS",
  "TOMADA TRIFÁSICA",
  "TOMADA",
  "TRANSFORMADOR",
  "TRITURADOR",
  "TUBULAÇÃO ELÉTRICA",
  "TUBULAÇÃO HIDRÁULICA",
  "TUBULAÇÃO",
  "TURBINA",
  "VALA ATERRAMENTO",
  "VALETA",
  "VENTILADOR DE TETO",
  "VENTILADOR PAREDE",
  "VERIFICAÇÃO DE INSTALAÇÃO ELÉTRICA",
>>>>>>> Stashed changes
];

List<String> tipoServico = [
<<<<<<< Updated upstream
  "Instalação",
  "Troca",
  "Medição",
  "Conferencia",
=======
  'ACOMPANHAMENTO',
  'ADEQUAÇÃO',
  'AFERIÇÃO',
  'AMARRAÇÃO',
  'APLICAÇÃO',
  'AUTOMATIZAÇÃO',
  'CARGA DE GÁS',
  'COBERTURA',
  'CONFIGURAÇÃO',
  'CONSERTO',
  'CONSULTORIA',
  'DESENTUPIMENTO',
  'DESLOCAMENTO',
  'FIXAÇÃO',
  'INFRA-ESTRUTURA',
  'INSTALAÇÃO',
  'LEVANTAMENTO',
  'LIMPEZA',
  'MATERIAL',
  'MEDIÇÃO',
  'MONTAGEM',
  'MUDANÇA',
  'PASSAGEM',
  'PERFURAÇÃO',
  'REBOBINAGEM',
  'REGULAGEM',
  'REMOÇÃO',
  'REPARO',
  'SERVIÇO',
  'SUBSTITUIÇÃO',
  'SUPORTE',
  'TALISCAMENTO',
  'VISTORIA',
>>>>>>> Stashed changes
];

int? _radioValue = 0;
List itens = [];
String _selectedValue = '';

class ItemAdd_Page extends StatefulWidget {
  final Customer cliente;
  const ItemAdd_Page({Key? key, required this.cliente}) : super(key: key);

  @override
  _ItemAdd_PageState createState() => _ItemAdd_PageState();
}

class _ItemAdd_PageState extends State<ItemAdd_Page> {
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  String? dropdownValue;
  String? dropdownValue2;
  @override
  Widget build(BuildContext context) {
    final txtControlPrecoUnidade = TextEditingController();
    final txtControlQuantidade = TextEditingController();
    final txtControlDescricao = TextEditingController();

    setState(() {});

    if (itens.length > 0) {
      valorTotal = itens
          .map((item) => item.unitPrice * item.quantity)
          .reduce((item1, item2) => item1 + item2);
    } else {
      valorTotal = 0;
    }

    Widget servico() {
      return Column(children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              //filled: true,
              labelText: "TIPO DE SERVIÇO",
            ),
            value: dropdownValue,
            onChanged: (value) {
              dropdownValue = value.toString();
              setState(() {});
            },
            items: tipoServico
                .map((tipo) =>
                    DropdownMenuItem(value: tipo, child: Text("$tipo")))
                .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'DESCRIÇÃO DO SERVIÇO',
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
      ]);
    }

    Widget material() {
      return Column(children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: TextFormField(
            readOnly: true,
            enabled: false,

            //controller: txtControlQuantidade,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(12, 23, 12, 22),
                labelText: 'RELAÇÃO DE MATERIAL',
                border: OutlineInputBorder()),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: TextFormField(
            controller: txtControlDescricao,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(12, 23, 12, 22),
                labelText: 'DESCRIÇÃO DO MATERIAL',
                border: OutlineInputBorder()),
          ),
        ),
      ]);
    }

    final TextEditingController _controller = new TextEditingController();
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
            Text(
              'SERVIÇO',
              style: TextStyle(color: Colors.black54),
            ),
            Radio(
              value: 1,
              groupValue: _radioValue,
              onChanged: (int? value) {
                _radioValue = value;
                setState(() {});
              },
            ),
            Text(
              'MATERIAIS',
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 210, 210, 210),
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 250),
              firstChild: servico(),
              secondChild: material(),
              crossFadeState: _radioValue == 0
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: TextFormField(
                controller: txtControlPrecoUnidade,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'R\$ ',
                    labelText: 'VALOR UNITARIO:',
                    border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: TextFormField(
                        controller: txtControlQuantidade,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'QUANTIDADE:',
                            border: OutlineInputBorder()),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 3, left: 3),
                    child: TextFormField(
                      //controller: txtControlQuantidade,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'UNIDADE:', border: OutlineInputBorder()),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(15),
                        ),
<<<<<<< Updated upstream
                        onPressed: () {
                          itens.add(InvoiceItem(
                              tipo: _radioValue == 0
                                  ? dropdownValue.toString()
                                  : 'Relação de Material',
                              description: _radioValue == 0
                                  ? dropdownValue2.toString()
                                  : txtControlDescricao.text,
                              date: DateTime.now(),
                              quantity: int.parse(txtControlQuantidade.text),
                              unitPrice:
                                  double.parse(txtControlPrecoUnidade.text)));
=======
                        onPressed: () async {
                          print('Apertou orcamento: $abriuOrcamento');
                          if (_radioValue == 0) {
                            if (txtControlTipo.text.isNotEmpty &&
                                txtControlDescricao.text.isNotEmpty) {
                              listaDeItens.invoices[index].items.add(
                                  new InvoiceItem(
                                      tipo: _radioValue == 0
                                          ? txtControlTipo.text
                                              .toString()
                                              .toUpperCase()
                                          : 'REL. DE MATERIAL',
                                      description: _radioValue == 0
                                          ? txtControlDescricao.text
                                              .toUpperCase()
                                          : txtControlDescricao.text
                                              .toUpperCase(),
                                      unidade: dropdownValue3,
                                      date: DateTime.now()
                                          .toString()
                                          .toUpperCase(),
                                      quantity: double.parse(
                                          txtControlQuantidade.text),
                                      unitPrice: (_radioValue == 1 &&
                                              txtControlPrecoUnidade
                                                  .text.isEmpty)
                                          ? 0
                                          : txtControlPrecoUnidade
                                              .numberValue));
                            }
                          } else {
                            listaDeItens.invoices[index].items.add(
                                new InvoiceItem(
                                    tipo: _radioValue == 0
                                        ? txtControlTipo.text
                                            .toString()
                                            .toUpperCase()
                                        : 'REL. DE MATERIAL',
                                    description: _radioValue == 0
                                        ? txtControlDescricao.text.toUpperCase()
                                        : txtControlDescricao.text
                                            .toUpperCase(),
                                    unidade: dropdownValue3,
                                    date:
                                        DateTime.now().toString().toUpperCase(),
                                    quantity:
                                        double.parse(txtControlQuantidade.text),
                                    unitPrice: (_radioValue == 1 &&
                                            txtControlPrecoUnidade.text.isEmpty)
                                        ? 0
                                        : txtControlPrecoUnidade.numberValue));
                          }

                          dropdownValue = null;
                          dropdownValue2 = null;
                          dropdownValue3 = unidadeServico[4];
                          txtControlDescricao.clear();
                          txtControlPrecoUnidade.clear();
                          txtControlQuantidade.clear();
                          txtControlTipo.clear();
                          FocusScope.of(context).requestFocus(new FocusNode());
>>>>>>> Stashed changes
                          setState(() {});
                        },
                        child: Icon(Icons.add)),
                  )
                ],
              ),
            ),
            Divider(),
            Text('RESUMO'),
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black26),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: InkWell(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ItemAddPage(
                                itensImport: itens,
                                cliente: widget.cliente,
                              )),
                    ).then((value) => setState(() {}));
                  },
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Table(
                          columnWidths: {0: FractionColumnWidth(.15)},
                          //border: TableBorder.all(),
                          children: [
                            for (var item in itens)
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Column(
                                      children: [
                                        Text(item.quantity.toString()),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(item.tipo.toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(item.description.toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                        'R\$ ${(item.unitPrice * item.quantity).toStringAsFixed(2)}'),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 8, left: 8),
                                    child:
                                        Text('Cliente: ${widget.cliente.name}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8, left: 8),
                                    child: Text('CPF: ${widget.cliente.doc}'),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8, top: 8, right: 8),
                                child: Text(
                                    'R\$ ${valorTotal.toStringAsFixed(2)}',
                                    textScaleFactor: 2,
                                    textAlign: TextAlign.end,
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
