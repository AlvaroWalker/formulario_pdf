import 'package:souza_autocenter/model/customer.dart';
import 'package:souza_autocenter/model/supplier.dart';

class Invoice {
  int id = 0;
  bool orcamento = true;
  bool pedido = false;
  double valorTotal = 0;
  String metPagamento = '';
  String observacoesPedido = '';
  String prazoServico = '';
  InvoiceInfo? info;
  Supplier? supplier;
  Customer? customer;
  List<InvoiceItem> items = <InvoiceItem>[];

  Invoice({
    required this.id,
    this.orcamento = true,
    this.pedido = false,
    this.valorTotal = 0,
    this.metPagamento = '',
    this.observacoesPedido = '',
    this.prazoServico = '',
    this.info,
    this.supplier,
    this.customer,
    required this.items,
  });
  Invoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orcamento = json['orcamento'];

    pedido = json['pedido'];
    valorTotal = json['valorTotal'];

    observacoesPedido = json['observacoesPedido'];

    metPagamento = json['metPagamento'];
    prazoServico = json['prazoServico'];
    info = json['InvoiceInfo'] != null
        ? InvoiceInfo.fromJson(json['InvoiceInfo'])
        : null;
    supplier = json['Supplier'] != null
        ? Supplier.fromJson(json['Supplier'])
        : null;
    customer = json['Customer'] != null
        ? Customer.fromJson(json['Customer'])
        : null;
    if (json['InvoiceItem'] != null) {
      items = <InvoiceItem>[];
      json['InvoiceItem'].forEach((v) {
        items.add(InvoiceItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;

    data['orcamento'] = orcamento;
    data['pedido'] = pedido;

    data['valorTotal'] = valorTotal;
    data['metPagamento'] = metPagamento;
    data['observacoesPedido'] = observacoesPedido;
    data['prazoServico'] = prazoServico;
    if (info != null) {
      data['InvoiceInfo'] = info?.toJson();
    }
    if (supplier != null) {
      data['Supplier'] = supplier?.toJson();
    }
    if (customer != null) {
      data['Customer'] = customer?.toJson();
    }
    data['InvoiceItem'] = items.map((v) => v.toJson()).toList();
    return data;
  }
}

class InvoiceInfo {
  String? description;
  String? number;
  String? date;
  String? dueDate;

  InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
  });
  InvoiceInfo.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    number = json['number'];
    date = json['date'];
    dueDate = json['dueDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['number'] = number;
    data['date'] = date;
    data['dueDate'] = dueDate;
    return data;
  }
}

class InvoiceItem {
  String? tipo;
  String? description;
  String? unidade;
  String? date;
  double? quantity;
  double? unitPrice;

  InvoiceItem({
    required this.tipo,
    required this.description,
    required this.unidade,
    required this.date,
    required this.quantity,
    required this.unitPrice,
  });
  InvoiceItem.fromJson(Map<String, dynamic> json) {
    tipo = json['tipo'];
    description = json['description'];
    unidade = json['unidade'];
    date = json['date'];
    quantity = json['quantity'];
    unitPrice = json['unitPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tipo'] = tipo;
    data['description'] = description;
    data['unidade'] = unidade;
    data['date'] = date;
    data['quantity'] = quantity;
    data['unitPrice'] = unitPrice;
    return data;
  }
}
