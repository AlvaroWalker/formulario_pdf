class Customer {
  final String name;
  final String doc;
  final String? inscEst;
  final String? razaoSocial;

  const Customer({
    required this.name,
    required this.doc,
    this.inscEst,
    this.razaoSocial,
  });
}
