class PaymentModel {
  final int id;

  PaymentModel({
    required this.id,
  });
  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(id: json['id']);
  }
}
