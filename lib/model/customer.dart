class Customer {
  final String name;
  final String doc;
  final String? inscEst;
  final String? razaoSocial;
  final String? clienteEndereco;
  final String? clienteBairro;
  final String? clienteCidade;
  final String? clienteEstado;
  final String? clienteTelefone;

  const Customer({
    required this.name,
    required this.doc,
    this.inscEst,
    this.razaoSocial,
    this.clienteEndereco,
    this.clienteBairro,
    this.clienteCidade,
    this.clienteEstado,
    this.clienteTelefone,
  });
}
