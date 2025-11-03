
class HomeModel {
  final int id;
  final String title;
  final int flightFrom;
  final String startDate;
  final String endDate;
  final String picture;
  final int duration;
  final int country;
  final List<DestinationModel> destinations;
  final List<CoreFeatureModel> coreFeatures;
  final List<PlanModel> plans;
  final bool isLiked;

  HomeModel({
    required this.id,
    required this.title,
    required this.flightFrom,
    required this.startDate,
    required this.endDate,
    required this.picture,
    required this.duration,
    required this.country,
    required this.destinations,
    required this.coreFeatures,
    required this.plans,
    this.isLiked = false,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      flightFrom: json['flight_from'] ?? 0,
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      picture: json['picture'] ?? '',
      duration: json['duration'] ?? 0,
      country: json['country'] ?? 0,
      destinations: (json['destinations'] as List?)
              ?.map((e) => DestinationModel.fromJson(e))
              .toList() ??
          [],
      coreFeatures: (json['core_features'] as List?)
              ?.map((e) => CoreFeatureModel.fromJson(e))
              .toList() ??
          [],
      plans: (json['plans'] as List?)
              ?.map((e) => PlanModel.fromJson(e))
              .toList() ??
          [],
      isLiked: json['is_liked'] ?? false,
    );
  }

  HomeModel copyWith({bool? isLiked}) {
    return HomeModel(
      id: id,
      title: title,
      flightFrom: flightFrom,
      startDate: startDate,
      endDate: endDate,
      picture: picture,
      duration: duration,
      country: country,
      destinations: destinations,
      coreFeatures: coreFeatures,
      plans: plans,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}

class DestinationModel {
  final String ccity;
  final int duration;

  DestinationModel({
    required this.ccity,
    required this.duration,
  });

  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      ccity: json['ccity'] ?? '',
      duration: json['duration'] ?? 0,
    );
  }

  String get name => ccity;
}

class CoreFeatureModel {
  final int id;
  final String title;
  final String icon;

  CoreFeatureModel({
    required this.id,
    required this.title,
    required this.icon,
  });

  factory CoreFeatureModel.fromJson(Map<String, dynamic> json) {
    return CoreFeatureModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      icon: json['icon'] ?? '',
    );
  }
}

class PlanModel {
  final int id;
  final String type;
  final int price;
  final int discount;
  final bool isDiscountActive;
  final String? discountExpiryDate;
  final double discountedPrice;
  final List<PlanFeatureModel> features;

  PlanModel({
    required this.id,
    required this.type,
    required this.price,
    required this.discount,
    required this.isDiscountActive,
    this.discountExpiryDate,
    required this.discountedPrice,
    required this.features,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      id: json['id'] ?? 0,
      type: json['type'] ?? '',
      price: json['price'] ?? 0,
      discount: json['discount'] ?? 0,
      isDiscountActive: json['is_discount_active'] ?? false,
      discountExpiryDate: json['discount_expiry_date'],
      discountedPrice: (json['discounted_price'] ?? 0).toDouble(),
      features: (json['features'] as List?)
              ?.map((e) => PlanFeatureModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class PlanFeatureModel {
  final int id;
  final String title;
  final String icon;

  PlanFeatureModel({
    required this.id,
    required this.title,
    required this.icon,
  });

  factory PlanFeatureModel.fromJson(Map<String, dynamic> json) {
    return PlanFeatureModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      icon: json['icon'] ?? '',
    );
  }
}

class PackageListResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<HomeModel> results;

  PackageListResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PackageListResponse.fromJson(Map<String, dynamic> json) {
    return PackageListResponse(
      count: json['count'] ?? 0,
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List?)
              ?.map((e) => HomeModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class PopularPlace {
  final int id;
  final String title;
  final String description;
  final String picture;
  final int getCount;

  PopularPlace({
    required this.id,
    required this.title,
    required this.description,
    required this.picture,
    required this.getCount,
  });

  factory PopularPlace.fromJson(Map<String, dynamic> json) {
    return PopularPlace(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      picture: json['picture'] ?? '',
      getCount: json['get_count'] ?? 0,
    );
  }
}
