
class OrderModel {
  final int id;
  final Package package;
  final Plan plan;
  final int priceTotal;
  final int pricePaid;
  final int getPriceToPay;
  final String status;
  final String created;
  final String fromCity;
  final String toCity;

  OrderModel({
    required this.id,
    required this.package,
    required this.plan,
    required this.priceTotal,
    required this.pricePaid,
    required this.getPriceToPay,
    required this.status,
    required this.created,
    required this.fromCity,
    required this.toCity,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      package: Package.fromJson(json['package']),
      plan: Plan.fromJson(json['plan']),
      priceTotal: json['price_total'],
      pricePaid: json['price_paid'],
      getPriceToPay: json['get_price_to_pay'],
      status: json['status'],
      created: json['created'],
      fromCity: json['from_city'],
      toCity: json['to_city'],
    );
  }
}

class Package {
  final int id;
  final String title;
  final String picture;

  Package({
    required this.id,
    required this.title,
    required this.picture,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json['id'],
      title: json['title'],
      picture: json['picture'],
    );
  }
}

class Plan {
  final int id;
  final PlanType type;

  Plan({
    required this.id,
    required this.type,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'],
      type: PlanType.fromJson(json['type']),
    );
  }
}

class PlanType {
  final int id;
  final String title;
  final String titleUz;
  final String titleRu;
  final String titleEn;
  final String titleUk;

  PlanType({
    required this.id,
    required this.title,
    required this.titleUz,
    required this.titleRu,
    required this.titleEn,
    required this.titleUk,
  });

  factory PlanType.fromJson(Map<String, dynamic> json) {
    return PlanType(
      id: json['id'],
      title: json['title'],
      titleUz: json['title_uz'],
      titleRu: json['title_ru'],
      titleEn: json['title_en'],
      titleUk: json['title_uk'],
    );
  }
}
