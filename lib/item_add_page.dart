import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formulario_pdf/resumo.dart';
import 'package:formulario_pdf/variaveis.dart';
import 'metodo_pag_page.dart';
import 'model/invoice.dart';

double valorTotal = 0;
List<String> descricaoServico = [
  "AQUECEDOR",
  "ATERRAMENTO",
  "BARRAMENTO",
  "BOMBA HIDRAÚLICA",
  "CABEAMENTO",
  "CAIXA DE PADRÃO",
  "CAIXA DE PASSAGEM",
  "CÂMERAS",
  "CANALETA",
  "CHAVE",
  "CHAVEADORA",
  "CHUVEIRO",
  "CLIMATIZADOR",
  "COMPRESSOR",
  "CONECTOR",
  "CONTATORA",
  "CONTROLADORA",
  "CURTO CIRCUITO",
  "DISJUNTORES",
  "ELÉTRICA",
  "ELETROCALHA",
  "ELETRODUTO",
  "EQUIPAMENTO",
  "EXAUSTOR",
  "FIAÇÃO",
  "FITA DE LED",
  "FONTE",
  "FUSÍVEL",
  "INTERFONE",
  "INTERRUPTOR COM TOMADA",
  "INTERRUPTOR DUPLO",
  "INTERRUPTORES",
  "LÂMPADA ",
  "LED",
  "LUMINÁRIA",
  "LUMINÁRIA DE EMBUTIR",
  "LUMINÁRIA DE SOBREPOR",
  "LUSTRE",
  "MANUTENÇÃO",
  "MÁQUINA ",
  "MOTOR",
  "PAINEL ",
  "PAINEL DE COMANDOS",
  "POSTE",
  "PROJETO",
  "QUADRO DE COMANDOS",
  "REATOR",
  "REDE DE INTERNET",
  "REDE SEM FIO",
  "REDE TRIFÁSICA",
  "REFLETOR",
  "RELÊ FOTOCÉLULA",
  "REPARO EMERGENCIAL",
  "RESISTENCIA",
  "SENSOR DE PRESENÇA",
  "SINALIZADOR DE OBSTÁCULO",
  "SINDAL",
  "SPOT",
  "SUPORTE ",
  "TELEFONE",
  "TERMINAIS",
  "TOMADAS",
  "TRANSFORMADOR",
  "TROCA DE CONJUNTOS",
  "TROCA DE LUMINÁRIAS",
  "TUBULAÇÃO ELÉTRICA",
  "VENTILADOR",
  "VENTILADOR DE PAREDE",
  "VENTILADOR DE TETO",
  "WAGO",
];

class DescricaoServico {
  String descricao;
  double valorServ = 0;

  DescricaoServico({
    required this.descricao,
    this.valorServ = 0,
  });
}

List<String> tipoServico = [
  "ACOMPANHAMENTO",
  "ADEQUAÇÃO",
  "AFERIÇÃO",
  "AVALIAÇÃO",
  "COMERCIAL",
  "CONFIGURAÇÃO",
  "CONSERTO",
  "CONSULTORIA",
  "DESLOCAMENTO",
  "DISJUNTORES",
  "ELÉTRICA",
  "ELETRICISTA 24 HORAS",
  "FIXAÇÃO",
  "ILUMINAÇAO ",
  "INFRAESTRUTURA",
  "INSTALAÇÃO",
  "LEVANTAMENTO",
  "MANUTENÇÃO",
  "MATERIAL",
  "MEDIÇÃO",
  "MONTAGEM",
  "MUDANÇA",
  "PASSAGEM",
  "PERFURAÇÃO",
  "PROJETO",
  "REPARO",
  "REPARO EMERGENCIAL",
  "RESIDENCIAL",
  "SERVIÇO",
  "SERVIÇOS",
  "SUBSTITUIÇÃO",
  "SUPORTE ",
  "TROCA",
  "VENTILADOR",
  "VISTORIA",
];

List<String> unidadeServico = [
  "Gm.",
  "Kg.",
  "MT",
  "BOB.",
  "UND",
  "KM",
  "KM/RODADO",
  "SC.",
  "CX.",
  "Lt.",
  "HORA",
  "M²",
  "M³",
];
int? _radioValue = 0;
//List itens = [];

class ItemAddPage extends StatefulWidget {
  final int? id;
  final Invoice? orcamentoEditar;
  const ItemAddPage({Key? key, this.id, this.orcamentoEditar})
      : super(key: key);

  @override
  _ItemAddPageState createState() => _ItemAddPageState();
}

class _ItemAddPageState extends State<ItemAddPage> {
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  String? dropdownValue;
  String? dropdownValue2;
  String? dropdownValue3 = unidadeServico[4];
  final txtControlPrecoUnidade = MoneyMaskedTextController();
  final txtControlQuantidade = TextEditingController();
  final txtControlTipo = TextEditingController();
  final txtControlDescricao = TextEditingController();
  @override
  Widget build(BuildContext context) {
    int index = listaDeItens.invoices
        .indexWhere((Invoice element) => element.id == widget.id);

    if (listaDeItens.invoices[index].items.length != 0) {
      valorTotal = listaDeItens.invoices[index].items
          .map((item) => item.unitPrice!.toDouble() * item.quantity!.toDouble())
          .reduce((item1, item2) => item1 + item2);
    } else {
      valorTotal = 0;
    }

    Widget servico() {
      return Column(children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: TextFormField(
            inputFormatters: [UpperCaseTextFormatter()],
            controller: txtControlTipo,
            decoration: InputDecoration(
              suffixIcon: PopupMenuButton(
                  icon: Icon(Icons.arrow_drop_down),
                  onSelected: (value) {
                    txtControlTipo.text = value.toString();
                    FocusScope.of(context).requestFocus(FocusNode());
                  },

                  //value: dropdownValue2,

                  itemBuilder: (context) {
                    return tipoServico
                        .map((cityTitle) => PopupMenuItem<String>(
                            textStyle:
                                TextStyle(fontSize: 12, color: Colors.black),
                            value: cityTitle,
                            child: Text("$cityTitle")))
                        .toList();
                  }),
              contentPadding: EdgeInsets.fromLTRB(12, 23, 12, 22),
              labelText: 'TIPO DE SERVIÇO',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: TextFormField(
            inputFormatters: [UpperCaseTextFormatter()],
            controller: txtControlDescricao,
            decoration: InputDecoration(
              suffixIcon: PopupMenuButton(
                  icon: Icon(Icons.arrow_drop_down),
                  onSelected: (value) {
                    txtControlDescricao.text = value.toString();
                    FocusScope.of(context).requestFocus(FocusNode());
                  },

                  //value: dropdownValue2,

                  itemBuilder: (context) {
                    return descricaoServico
                        .map((cityTitle) => PopupMenuItem<String>(
                            textStyle:
                                TextStyle(fontSize: 12, color: Colors.black),
                            value: cityTitle,
                            child: Text("$cityTitle")))
                        .toList();
                  }),
              contentPadding: EdgeInsets.fromLTRB(12, 23, 12, 22),
              labelText: 'DESCRIÇÃO DO SERVIÇO',
            ),
          ),
        ),
      ]);
    }

//
//
//
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
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  // color: Color(0xFFFF7E00),
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                  //  color: Color(0xFFFF7E00),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: TextFormField(
            controller: txtControlDescricao,
            inputFormatters: [UpperCaseTextFormatter()],
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(12, 23, 12, 22),
              labelText: 'DESCRIÇÃO DO MATERIAL',
            ),
          ),
        ),
      ]);
    }

//
//
//
    return Scaffold(
      floatingActionButton: Visibility(
        visible: listaDeItens.invoices[index].items.isNotEmpty,
        child: FloatingActionButton(
          onPressed: () async {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CondPagamentoWidget(indexOfItem: index)))
                .then((value) => setState(() {}));
          },
          //backgroundColor: Color(0xFFFF5600),
          elevation: 8,
          child: Icon(
            Icons.navigate_next,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
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
                setState(() {
                  FocusScope.of(context).requestFocus(new FocusNode());
                });
              },
            ),
            Text(
              'SERVIÇO',
              textScaleFactor: .7,
              style: TextStyle(color: Colors.black54),
            ),
            Radio(
              value: 1,
              groupValue: _radioValue,
              onChanged: (int? value) {
                _radioValue = value;
                setState(() {
                  FocusScope.of(context).requestFocus(new FocusNode());
                });
              },
            ),
            Text(
              'MATERIAIS',
              textScaleFactor: .7,
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 210, 210, 210),
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: AnimatedCrossFade(
                duration: const Duration(milliseconds: 250),
                firstChild: servico(),
                secondChild: material(),
                crossFadeState: _radioValue == 0
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 13, right: 13, top: 3, bottom: 3),
              child: TextFormField(
                controller: txtControlPrecoUnidade,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixText: 'R\$ ',
                  labelText: 'VALOR UNITARIO:',
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 13, right: 13, top: 3, bottom: 3),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: TextFormField(
                        controller: txtControlQuantidade,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(12, 23, 12, 22),
                          labelText: 'QUANTIDADE:',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'UNIDADE',
                      ),
                      value: dropdownValue3,
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue3 = value.toString();

                          FocusScope.of(context).requestFocus(new FocusNode());
                        });
                      },
                      items: unidadeServico
                          .map((cityTitle) => DropdownMenuItem(
                              value: cityTitle, child: Text("$cityTitle")))
                          .toList(),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(15),
                        ),
                        onPressed: () async {
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
                          setState(() {});
                        },
                        child: Icon(Icons.add)),
                  )
                ],
              ),
            ),
            Divider(),
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
              index: index,
            )
          ],
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
