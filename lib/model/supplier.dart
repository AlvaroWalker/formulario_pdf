class Supplier {
  String? name;
  String? address;
  String? paymentInfo;

  Supplier({
    required this.name,
    required this.address,
    required this.paymentInfo,
  });
  Supplier.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['adress'];
    paymentInfo = json['paymentInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['adress'] = address;
    data['paymentInfo'] = paymentInfo;
    return data;
  }
}
