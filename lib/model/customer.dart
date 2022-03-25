class Customer {
  String name = '';
  String doc = '';
  String? veiculo;
  String? razaoSocial;
  String? clienteEndereco;
  String? clienteBairro;
  String? clienteCidade;
  String? clienteEstado;
  String? clienteTelefone;

  Customer({
    required this.name,
    required this.doc,
    this.veiculo,
    this.razaoSocial,
    this.clienteEndereco,
    this.clienteBairro,
    this.clienteCidade,
    this.clienteEstado,
    this.clienteTelefone,
  });
  Customer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    doc = json['doc'];
    veiculo = json['veiculo'];
    razaoSocial = json['razaoSocial'];
    clienteEndereco = json['clienteEndereco'];
    clienteBairro = json['clienteBairro'];
    clienteCidade = json['clienteCidade'];
    clienteEstado = json['clienteEstado'];
    clienteTelefone = json['clienteTelefone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['doc'] = this.doc;
    data['veiculo'] = this.veiculo;
    data['razaoSocial'] = this.razaoSocial;
    data['clienteEndereco'] = this.clienteEndereco;
    data['clienteBairro'] = this.clienteBairro;
    data['clienteCidade'] = this.clienteCidade;
    data['clienteEstado'] = this.clienteEstado;
    data['clienteTelefone'] = this.clienteTelefone;
    return data;
  }
}
