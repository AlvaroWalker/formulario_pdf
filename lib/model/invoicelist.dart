import 'invoice.dart';

class InvoiceList {
  List<Invoice> invoices = [];

  InvoiceList({required this.invoices});

  InvoiceList.fromJson(Map<String, dynamic> json) {
    if (json['invoice'] != null) {
      invoices = <Invoice>[];
      json['invoice'].forEach((v) {
        invoices.add(Invoice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['invoice'] = invoices.map((v) => v.toJson()).toList();

    return data;
  }
}
