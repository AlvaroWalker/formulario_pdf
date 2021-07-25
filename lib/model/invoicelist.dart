import 'invoice.dart';

class InvoiceList {
  List<Invoice> invoices = [];

  InvoiceList({required this.invoices});

  InvoiceList.fromJson(Map<String, dynamic> json) {
    if (json['invoice'] != null) {
      invoices = <Invoice>[];
      json['invoice'].forEach((v) {
        invoices?.add(new Invoice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.invoices != null) {
      data['invoice'] = this.invoices?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
