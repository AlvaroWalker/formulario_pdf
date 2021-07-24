import 'package:formulario_pdf/model/customer.dart';
import 'package:formulario_pdf/model/supplier.dart';

class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceItem> items;

  const Invoice({
    required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;

  const InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
  });
}

class InvoiceItem {
  final String tipo;
  final String description;
  final DateTime date;
  final int quantity;
  final double unitPrice;

  const InvoiceItem({
    required this.tipo,
    required this.description,
    required this.date,
    required this.quantity,
    required this.unitPrice,
  });
}
