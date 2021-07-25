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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['adress'] = this.address;
    data['paymentInfo'] = this.paymentInfo;
    return data;
  }
}
