class PaymentModel {
  final int id;
  final CategoryInPaymentList category;
  final int payee;
  final int responsible;
  final int amount;
  final String status;
  final String created;

  PaymentModel({
    required this.id,
    required this.category,
    required this.payee,
    required this.responsible,
    required this.amount,
    required this.status,
    required this.created,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'],
      category: CategoryInPaymentList.fromJson(json['category']),
      payee: json['payee'],
      responsible: json['responsible'],
      amount: json['amount'],
      status: json['status'],
      created: json['created'],
    );
  }
}

class CategoryInPaymentList {
  final int id;
  final String title;

  CategoryInPaymentList({
    required this.id,
    required this.title,
  });

  factory CategoryInPaymentList.fromJson(Map<String, dynamic> json) {
    return CategoryInPaymentList(
      id: json['id'],
      title: json['title'],
    );
  }
}
