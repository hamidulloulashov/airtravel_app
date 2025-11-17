class PackagePicture {
  final int id;
  final String picture; // Rasm URL
  final bool isMain;

  PackagePicture({
    required this.id,
    required this.picture,
    required this.isMain,
  });

  factory PackagePicture.fromJson(Map<String, dynamic> json) {
    return PackagePicture(
      id: json['id']  ,
      picture: json['picture'],
      isMain: json['is_main'],
    );
  }
}

class PackageDestination {
  final String city;
  final int duration;

  PackageDestination({
    required this.city,
    required this.duration,
  });

  factory PackageDestination.fromJson(Map<String, dynamic> json) {
    return PackageDestination(
      city: json['ccity']  ,
      duration: json['duration']  ,
    );
  }
}

class Feature {
  final int id;
  final String title;
  final String icon;
  final String? description;

  Feature({
    required this.id,
    required this.title,
    required this.icon,
    this.description,
  });

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      id: json['id']  ,
      title: json['title']  ,
      icon: json['icon']  ,
      description: json['description'],
    );
  }
}

class PlanType {
  final String title;

  PlanType({required this.title});

  factory PlanType.fromJson(Map<String, dynamic> json) {
    return PlanType(
      title: json['title']  ,
    );
  }
}

class UmraTariff {
  final int id;
  final PlanType type;
  final int price;
  final bool isDiscountActive;
  final int discount;
  final int discountedPrice;
  final List<Feature> features;
  final String? description;

  UmraTariff({
    required this.id,
    required this.type,
    required this.price,
    required this.isDiscountActive,
    required this.discount,
    required this.discountedPrice,
    required this.features,
    this.description,
  });

  factory UmraTariff.fromJson(Map<String, dynamic> json) {
    return UmraTariff(
      id: json['id']  ,
      type: PlanType.fromJson(json['type'] as Map<String, dynamic>),
      price: json['price']  ,
      isDiscountActive: json['is_discount_active'] as bool,
      discount: json['discount']  ,
      discountedPrice: json['discounted_price']  ,
      features: (json['features'] as List<dynamic>)
          .map((item) => Feature.fromJson(item as Map<String, dynamic>))
          .toList(),
      description: json['description'],
    );
  }
}
class PackageDay {
  final int id;
  final int dayNumber;
  final String date;

  PackageDay({
    required this.id,
    required this.dayNumber,
    required this.date,
  });

  factory PackageDay.fromJson(Map<String, dynamic> json) {
    return PackageDay(
      id: json['id']  ,
      dayNumber: json['day_number']  ,
      date: json['date']  ,
    );
  }
}

class DetailModel {
  final int id;
  final String title;
  final int flightFrom;
  final String startDate;
  final String endDate;
  final String description;
  final int country;
  final List<PackagePicture> pictures;
  final int duration;
  final List<PackageDestination> destinations;
  final List<Feature> coreFeatures;
  final List<UmraTariff> plans; 
  final List<PackageDay> days; 

  DetailModel({
    required this.id,
    required this.title,
    required this.flightFrom,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.country,
    required this.pictures,
    required this.duration,
    required this.destinations,
    required this.coreFeatures,
    required this.plans,
    required this.days,
  });

  factory DetailModel.fromJson(Map<String, dynamic> json) {
    return DetailModel(
      id: json['id'],
      title: json['title'],
      flightFrom: json['flight_from'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      description: json['description'],
      country: json['country'],
      pictures: (json['pictures'] as List<dynamic>)
          .map((item) => PackagePicture.fromJson(item as Map<String, dynamic>))
          .toList(),
      duration: json['duration']  ,
      destinations: (json['destinations'] as List<dynamic>)
          .map((item) => PackageDestination.fromJson(item as Map<String, dynamic>))
          .toList(),
      coreFeatures: (json['core_features'] as List<dynamic>)
          .map((item) => Feature.fromJson(item as Map<String, dynamic>))
          .toList(),
      plans: (json['plans'] as List<dynamic>)
          .map((item) => UmraTariff.fromJson(item as Map<String, dynamic>))
          .toList(),
      days: (json['days'] as List<dynamic>)
          .map((item) => PackageDay.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}