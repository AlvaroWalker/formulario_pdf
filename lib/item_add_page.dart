import 'package:flutter/material.dart';
import 'package:formulario_pdf/resumo.dart';
import 'package:formulario_pdf/variaveis.dart';
import 'metodo_pag_page.dart';
import 'model/invoice.dart';

double valorTotal = 0;

List<String> descricaoServico = [
  "AR CONDICIONADO",
  "ATERRAMENTO",
  "BOMBA DE POÇO",
  "BOMBA SAPO",
  "BOMBA HIDRÁULICA",
  "CABEAMENTO",
  "CAIXA DE PADRÃO",
  "CAIXA DE PASSAGEM",
  "CHUVEIRO ",
  "COMPRESSOR",
  "CONTATORA",
  "CHAVE",
  "CANELINHA",
  "TERMINAIS",
  "FUSÍVEIS",
  "MOTOR",
  "MÁQUINA",
  "TRITURADOR",
  "LUMINÁRIA DE EMBUTIR",
  "LUMINÁRIA",
  "POSTE DE PADRÃO COM CAIXA",
  "POSTE CONCRETO 7m",
  "POSTE CONCRETO 8m",
  "POSTE CONCRETO 6m",
  "POSTE CONCRETO 9m",
  "POSTE CONCRETO 10m",
  "POSTE CONCRETO 11m",
  "SUPER-POSTE",
  "TRANSFORMADOR",
  "TURBINA",
  "COMPRESSOR",
  "CORRENTE",
  "ELETRODUTO",
  "CONTROLADORA",
  "DISJUNTOR",
  "QUADRO DE COMANDO",
  "PAINEL DE COMANDO",
  "PAINEL",
  "PORTÃO ELETRÔNICO",
  "INTERFONE",
  "SIRENE",
  "EXAUSTOR",
  "HIDRANTE",
  "TOMADA TRIFÁSICA",
  "TOMADA",
  "INTERRUPTOR COM TOMADA",
  "INTERRUPTOR DUPLO COM TOMADA",
  "INTERRUPTOR 3 TECLAS",
  "LUMINÁRIA",
  "LUMINÁRIA DE EMBUTIR",
  "LUMINÁRIA DE SOBREPOR",
  "LUMINÁRIA DE EMERGÊNCIA",
  "LAMPADA DE POSTRE",
  "LUMINÁRIA DICRÓICA",
  "REFLETOR",
  "PADRÃO ",
  "PROJETOR",
  "PROJETO TÉCNICO",
  "PROJETO ELÉTROTÉCNICO",
  "QUADRO DE DISTRIBUIÇÃO INDIVIDUAL",
  "QUADRO DE MEDIÇÃO AGRUPADO",
  "REATOR DE POSTE",
  "REDE BIFÁSICA",
  "REDE TRIFÁSICA",
  "REDE MONOFÁSICA",
  "RELÉ",
  "RELÉ CÍCLICO",
  "RELÉ DE TEMPO",
  "RELÉ FALTA DE FASE",
  "RELÉ FOTO CÉLULA",
  "REDE ALTA TENSÃO",
  "TENSÃO",
  "CANALETA",
  "TUBULAÇÃO",
  "ELETRO CALHA",
  "TUBULAÇÃO ELÉTRICA",
  "TUBULAÇÃO HIDRÁULICA",
  "HIDRANTE",
  "VENTILADOR PAREDE",
  "VENTILADOR DE TETO",
  "CLIMATIZADOR ",
  "VALETA",
  "VALA ATERRAMENTO",
  "PARA-RAIOS",
  "SPDA",
  "HASTES",
  "ROTEADOR",
  "REDE SEM FIO",
  "REDE DE INTERNET",
  "GEORREFENCIADO ",
  "LOCAL",
];

List<String> tipoServico = [
  'AFERIÇÃO',
  'SERVIÇO',
  'CARGA DE GÁS',
  'CONSERTO',
  'DESLOCAMENTO',
  'INFRA-ESTRUTURA',
  'LIMPEZA',
  'MATERIAL',
  'MEDIÇÃO',
  'MONTAGEM',
  'REGULAGEM',
  'REMOÇÃO',
  'REPARO',
  'SUBSTITUIÇÃO',
  'PERFURAÇÃO',
  'APLICAÇÃO',
  'COBERTURA',
  'PASSAGEM',
  'TALISCAMENTO',
  'VISTORIA',
  'ACOMPANHAMENTO',
  'LEVANTAMENTO',
  'DESENTUPIMENTO',
  'AMARRAÇÃO',
  'REBOBINAGEM',
  'AUTOMATIZAÇÃO',
  'MUDANÇA',
  'ADEQUAÇÃO',
  'FIXAÇÃO',
  'CONFIGURAÇÃO',
  'SUPORTE',
  'CONSULTORIA',
];

List<String> unidadeServico = [
  "Gm.",
  "Kg.",
  "Mt.",
  "BOB.",
  "UND.",
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

class ItemAdd_Page extends StatefulWidget {
  final int id;
  const ItemAdd_Page({Key? key, required this.id}) : super(key: key);

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
  String? dropdownValue3;
  final txtControlPrecoUnidade = TextEditingController();
  final txtControlQuantidade = TextEditingController();
  final txtControlDescricao = TextEditingController();
  @override
  Widget build(BuildContext context) {
    setState(() {});
    int index = listaDeItens.invoices
        .indexWhere((Invoice element) => element.id == widget.id);

    if (listaDeItens.invoices[index].items.length != 0) {
      valorTotal = listaDeItens.invoices[index].items
          .map((item) => item.unitPrice!.toDouble() * item.quantity!.toInt())
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
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFFF7E00),
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                  color: Color(0xFFFF7E00),
                  width: 1,
                ),
              ),
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
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFFF7E00),
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                  color: Color(0xFFFF7E00),
                  width: 1,
                ),
              ),
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
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFFF7E00),
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
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
          padding: const EdgeInsets.all(3.0),
          child: TextFormField(
            controller: txtControlDescricao,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(12, 23, 12, 22),
              labelText: 'DESCRIÇÃO DO MATERIAL',
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
      ]);
    }

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
          backgroundColor: Color(0xFFFF5600),
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
                  hintText: 'R\$ ',
                  labelText: 'VALOR UNITARIO:',
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
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(3),
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
                        labelText: 'UNIDADE',
                      ),
                      value: dropdownValue3,
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue3 = value.toString();
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
                          listaDeItens.invoices[index].items.add(
                              new InvoiceItem(
                                  tipo: _radioValue == 0
                                      ? dropdownValue.toString()
                                      : 'Relação de Material',
                                  description: _radioValue == 0
                                      ? dropdownValue2.toString()
                                      : txtControlDescricao.text,
                                  unidade: dropdownValue3,
                                  date: DateTime.now().toString(),
                                  quantity:
                                      int.parse(txtControlQuantidade.text),
                                  unitPrice: double.parse(
                                      txtControlPrecoUnidade.text)));
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
