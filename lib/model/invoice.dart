import 'package:formulario_pdf/model/customer.dart';
import 'package:formulario_pdf/model/supplier.dart';

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
        ? new InvoiceInfo.fromJson(json['InvoiceInfo'])
        : null;
    supplier = json['Supplier'] != null
        ? new Supplier.fromJson(json['Supplier'])
        : null;
    customer = json['Customer'] != null
        ? new Customer.fromJson(json['Customer'])
        : null;
    if (json['InvoiceItem'] != null) {
      items = <InvoiceItem>[];
      json['InvoiceItem'].forEach((v) {
        items.add(new InvoiceItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    data['orcamento'] = this.orcamento;
    data['pedido'] = this.pedido;

    data['valorTotal'] = this.valorTotal;
    data['metPagamento'] = this.metPagamento;
    data['observacoesPedido'] = this.observacoesPedido;
    data['prazoServico'] = this.prazoServico;
    if (this.info != null) {
      data['InvoiceInfo'] = this.info?.toJson();
    }
    if (this.supplier != null) {
      data['Supplier'] = this.supplier?.toJson();
    }
    if (this.customer != null) {
      data['Customer'] = this.customer?.toJson();
    }
    data['InvoiceItem'] = this.items.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['number'] = this.number;
    data['date'] = this.date;
    data['dueDate'] = this.dueDate;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tipo'] = this.tipo;
    data['description'] = this.description;
    data['unidade'] = this.unidade;
    data['date'] = this.date;
    data['quantity'] = this.quantity;
    data['unitPrice'] = this.unitPrice;
    return data;
  }
}
