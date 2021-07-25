import 'package:formulario_pdf/model/customer.dart';
import 'package:formulario_pdf/model/supplier.dart';

class Invoice {
  int id = 0;
  double valorTotal = 0;
  InvoiceInfo? info;
  Supplier? supplier;
  Customer? customer;
  List<InvoiceItem> items = <InvoiceItem>[];

  Invoice({
    required this.id,
    this.valorTotal = 0,
    this.info,
    this.supplier,
    this.customer,
    required this.items,
  });
  Invoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
        items?.add(new InvoiceItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.info != null) {
      data['InvoiceInfo'] = this.info?.toJson();
    }
    if (this.supplier != null) {
      data['Supplier'] = this.supplier?.toJson();
    }
    if (this.customer != null) {
      data['Customer'] = this.customer?.toJson();
    }
    if (this.items != null) {
      data['InvoiceItem'] = this.items?.map((v) => v.toJson()).toList();
    }
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
  String? date;
  int? quantity;
  double? unitPrice;

  InvoiceItem({
    required this.tipo,
    required this.description,
    required this.date,
    required this.quantity,
    required this.unitPrice,
  });
  InvoiceItem.fromJson(Map<String, dynamic> json) {
    tipo = json['tipo'];
    description = json['description'];
    date = json['date'];
    quantity = json['quantity'];
    unitPrice = json['unitPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tipo'] = this.tipo;
    data['description'] = this.description;
    data['date'] = this.date;
    data['quantity'] = this.quantity;
    data['unitPrice'] = this.unitPrice;
    return data;
  }
}
