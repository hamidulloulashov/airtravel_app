

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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'picture': picture,
      'get_count': getCount,
    };
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
              ?.map((e) => HomeModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.map((e) => e.toJson()).toList(),
    };
  }

  bool get hasMore => next != null;

  bool get isEmpty => results.isEmpty;

  bool get isNotEmpty => results.isNotEmpty;
}



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
              ?.map((e) => DestinationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      coreFeatures: (json['core_features'] as List?)
              ?.map((e) => CoreFeatureModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      plans: (json['plans'] as List?)
              ?.map((e) => PlanModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      isLiked: json['is_liked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'flight_from': flightFrom,
      'start_date': startDate,
      'end_date': endDate,
      'picture': picture,
      'duration': duration,
      'country': country,
      'destinations': destinations.map((e) => e.toJson()).toList(),
      'core_features': coreFeatures.map((e) => e.toJson()).toList(),
      'plans': plans.map((e) => e.toJson()).toList(),
      'is_liked': isLiked,
    };
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


  bool get hasDiscount {
    return plans.any((plan) => plan.isDiscountActive && plan.discount > 0);
  }

  int get maxDiscount {
    if (plans.isEmpty) return 0;
    return plans
        .where((plan) => plan.isDiscountActive)
        .map((plan) => plan.discount)
        .fold(0, (max, discount) => discount > max ? discount : max);
  }

  String get destinationCities {
    if (destinations.isEmpty) return 'Manzil ko\'rsatilmagan';
    return destinations
        .map((d) => d.ccity)
        .where((city) => city.isNotEmpty)
        .join(', ');
  }

  int get totalDestinationDays {
    return destinations.fold(0, (sum, dest) => sum + dest.duration);
  }

  PlanModel? get cheapestPlan {
    if (plans.isEmpty) return null;
    return plans.reduce((curr, next) => 
      curr.finalPrice < next.finalPrice ? curr : next
    );
  }

  PlanModel? get mostExpensivePlan {
    if (plans.isEmpty) return null;
    return plans.reduce((curr, next) => 
      curr.finalPrice > next.finalPrice ? curr : next
    );
  }

  bool get hasValidDates {
    if (startDate.isEmpty || endDate.isEmpty) return false;
    try {
      final start = DateTime.parse(startDate);
      final end = DateTime.parse(endDate);
      return end.isAfter(start);
    } catch (e) {
      return false;
    }
  }

  String get dateRange {
    try {
      final start = DateTime.parse(startDate);
      final end = DateTime.parse(endDate);
      return '${start.day} ${_getMonthName(start.month)} - ${end.day} ${_getMonthName(end.month)}';
    } catch (e) {
      return 'Sana noma\'lum';
    }
  }

  int get daysUntilStart {
    try {
      final start = DateTime.parse(startDate);
      final now = DateTime.now();
      return start.difference(now).inDays;
    } catch (e) {
      return 0;
    }
  }

  bool get isBookingAvailable {
    return daysUntilStart > 0;
  }

  String get priceRange {
    if (plans.isEmpty) return '\$0';
    final cheapest = cheapestPlan?.finalPrice ?? 0;
    final expensive = mostExpensivePlan?.finalPrice ?? 0;
    if (cheapest == expensive) {
      return '\$${cheapest.toStringAsFixed(0)}';
    }
    return '\$${cheapest.toStringAsFixed(0)} - \$${expensive.toStringAsFixed(0)}';
  }

  String _getMonthName(int month) {
    const months = [
      'Yan', 'Fev', 'Mar', 'Apr', 'May', 'Iyun',
      'Iyul', 'Avg', 'Sen', 'Okt', 'Noy', 'Dek'
    ];
    return months[month - 1];
  }
}

typedef Package = HomeModel;



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

  Map<String, dynamic> toJson() {
    return {
      'ccity': ccity,
      'duration': duration,
    };
  }

  String get name => ccity;

  String get formattedDuration {
    if (duration == 1) return '1 kun';
    return '$duration kun';
  }
}

typedef Destination = DestinationModel;



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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
    };
  }
}


typedef CoreFeature = CoreFeatureModel;



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
    double parseDiscountedPrice(dynamic value) {
      if (value == null) return 0.0;
      if (value is int) return value.toDouble();
      if (value is double) return value;
      if (value is String) {
        return double.tryParse(value) ?? 0.0;
      }
      return 0.0;
    }

    return PlanModel(
      id: json['id'] ?? 0,
      type: json['type'] ?? '',
      price: json['price'] ?? 0,
      discount: json['discount'] ?? 0,
      isDiscountActive: json['is_discount_active'] ?? false,
      discountExpiryDate: json['discount_expiry_date'],
      discountedPrice: parseDiscountedPrice(json['discounted_price']),
      features: (json['features'] as List?)
              ?.map((e) => PlanFeatureModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'price': price,
      'discount': discount,
      'is_discount_active': isDiscountActive,
      'discount_expiry_date': discountExpiryDate,
      'discounted_price': discountedPrice,
      'features': features.map((e) => e.toJson()).toList(),
    };
  }

  double get finalPrice {
    if (isDiscountActive && discountedPrice > 0) {
      return discountedPrice;
    }
    return price.toDouble();
  }

  bool get isDiscountValid {
    if (!isDiscountActive) return false;
    if (discountExpiryDate == null) return true;

    try {
      final expiryDate = DateTime.parse(discountExpiryDate!);
      return DateTime.now().isBefore(expiryDate);
    } catch (e) {
      return false;
    }
  }

  double get savingsAmount {
    if (!isDiscountActive || discount == 0) return 0;
    return price - discountedPrice;
  }

  double get savingsPercentage {
    if (price == 0) return 0;
    return (savingsAmount / price) * 100;
  }

  String get formattedPrice {
    return '\$${finalPrice.toStringAsFixed(0)}';
  }

  String get formattedOriginalPrice {
    return '\$${price.toString()}';
  }

  String get formattedDiscount {
    if (discount == 0) return '';
    return '-$discount%';
  }

  int? get daysUntilDiscountExpires {
    if (discountExpiryDate == null) return null;
    try {
      final expiryDate = DateTime.parse(discountExpiryDate!);
      final now = DateTime.now();
      return expiryDate.difference(now).inDays;
    } catch (e) {
      return null;
    }
  }

  bool get isDiscountExpiringSoon {
    final days = daysUntilDiscountExpires;
    return days != null && days > 0 && days <= 3;
  }
}

typedef Plan = PlanModel;


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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
    };
  }
}

typedef PlanFeature = PlanFeatureModel;



extension StringDateExtension on String {
  String toReadableDate() {
    try {
      final date = DateTime.parse(this);
      const months = [
        'Yan', 'Fev', 'Mar', 'Apr', 'May', 'Iyun',
        'Iyul', 'Avg', 'Sen', 'Okt', 'Noy', 'Dek'
      ];
      return '${date.day} ${months[date.month - 1]}';
    } catch (e) {
      return this;
    }
  }

  String toReadableDateWithYear() {
    try {
      final date = DateTime.parse(this);
      const months = [
        'Yan', 'Fev', 'Mar', 'Apr', 'May', 'Iyun',
        'Iyul', 'Avg', 'Sen', 'Okt', 'Noy', 'Dek'
      ];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    } catch (e) {
      return this;
    }
  }

  bool get isFutureDate {
    try {
      final date = DateTime.parse(this);
      return date.isAfter(DateTime.now());
    } catch (e) {
      return false;
    }
  }

  int get daysUntil {
    try {
      final date = DateTime.parse(this);
      final now = DateTime.now();
      return date.difference(now).inDays;
    } catch (e) {
      return 0;
    }
  }

  int get daysSince {
    try {
      final date = DateTime.parse(this);
      final now = DateTime.now();
      return now.difference(date).inDays;
    } catch (e) {
      return 0;
    }
  }
}

extension DoublePriceExtension on double {
  String toPrice({String currency = '\$'}) {
    return '$currency${toStringAsFixed(0)}';
  }

  String toPriceWithSeparator({String currency = '\$'}) {
    final formatter = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    final price = toStringAsFixed(0);
    final formatted = price.replaceAllMapped(
      formatter, 
      (match) => '${match[1]},'
    );
    return '$currency$formatted';
  }

  String toPriceWithDecimals({String currency = '\$', int decimals = 2}) {
    return '$currency${toStringAsFixed(decimals)}';
  }
}

extension IntPriceExtension on int {
  String toPrice({String currency = '\$'}) {
    return '$currency$this';
  }

  String toPriceWithSeparator({String currency = '\$'}) {
    final formatter = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    final price = toString();
    final formatted = price.replaceAllMapped(
      formatter, 
      (match) => '${match[1]},'
    );
    return '$currency$formatted';
  }

  String toDuration() {
    if (this == 1) return '1 kun';
    return '$this kun';
  }
}

extension ListHomeModelExtension on List<HomeModel> {
  List<HomeModel> filterByDestination(String destination) {
    return where((package) => 
      package.destinationCities
        .toLowerCase()
        .contains(destination.toLowerCase())
    ).toList();
  }

  List<HomeModel> filterByPriceRange({int? minPrice, int? maxPrice}) {
    return where((package) {
      final cheapest = package.cheapestPlan?.finalPrice ?? 0;
      if (minPrice != null && cheapest < minPrice) return false;
      if (maxPrice != null && cheapest > maxPrice) return false;
      return true;
    }).toList();
  }

  List<HomeModel> filterByDuration({int? minDuration, int? maxDuration}) {
    return where((package) {
      if (minDuration != null && package.duration < minDuration) return false;
      if (maxDuration != null && package.duration > maxDuration) return false;
      return true;
    }).toList();
  }

  List<HomeModel> filterByDiscount() {
    return where((package) => package.hasDiscount).toList();
  }

  List<HomeModel> sortByPriceAsc() {
    final sorted = List<HomeModel>.from(this);
    sorted.sort((a, b) {
      final priceA = a.cheapestPlan?.finalPrice ?? double.infinity;
      final priceB = b.cheapestPlan?.finalPrice ?? double.infinity;
      return priceA.compareTo(priceB);
    });
    return sorted;
  }

  List<HomeModel> sortByPriceDesc() {
    final sorted = List<HomeModel>.from(this);
    sorted.sort((a, b) {
      final priceA = a.cheapestPlan?.finalPrice ?? 0;
      final priceB = b.cheapestPlan?.finalPrice ?? 0;
      return priceB.compareTo(priceA);
    });
    return sorted;
  }

  List<HomeModel> sortByDurationAsc() {
    final sorted = List<HomeModel>.from(this);
    sorted.sort((a, b) => a.duration.compareTo(b.duration));
    return sorted;
  }

  List<HomeModel> sortByDurationDesc() {
    final sorted = List<HomeModel>.from(this);
    sorted.sort((a, b) => b.duration.compareTo(a.duration));
    return sorted;
  }

  List<HomeModel> sortByDiscount() {
    final sorted = List<HomeModel>.from(this);
    sorted.sort((a, b) => b.maxDiscount.compareTo(a.maxDiscount));
    return sorted;
  }
}