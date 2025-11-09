class AccommodationModel {
  final int id;
  final String title;
  final AccommodationType type;
  final String longDescription;
  final String rating;
  final City? city;
  final String country;
  final String address;
  final String landmark;
  final List<Feature> features;
  final String iframe;
  final String latitude;
  final String longitude;
  final List<Picture> pictures;
  final String embeddedLink;

  AccommodationModel({
    required this.id,
    required this.title,
    required this.type,
    required this.longDescription,
    required this.rating,
    this.city,
    required this.country,
    required this.address,
    required this.landmark,
    this.features = const [],
    required this.iframe,
    required this.latitude,
    required this.longitude,
    this.pictures = const [],
    required this.embeddedLink,
  });

  factory AccommodationModel.fromJson(Map<String, dynamic> json) {
    return AccommodationModel(
      id: json['id'],
      title: json['title'] ?? '',
      type: AccommodationType.fromJson(json['type']),
      longDescription: json['long_description'],
      rating: json['rating'],
      city: json['city'] != null ? City.fromJson(json['city']) : null,
      country: json['country'],
      address: json['address'],
      landmark: json['landmark'],
      features: (json['features'] as List<dynamic>?)
          ?.map((e) => Feature.fromJson(e))
          .toList() ??
          [],
      iframe: json['iframe'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      pictures: (json['pictures'] as List<dynamic>?)
          ?.map((e) => Picture.fromJson(e))
          .toList() ??
          [],
      embeddedLink: json['embedded_link'],
    );
  }
}

class AccommodationType {
  final String title;
  final String? picture;

  AccommodationType({
    required this.title,
    this.picture,
  });

  factory AccommodationType.fromJson(Map<String, dynamic> json) {
    return AccommodationType(
      title: json['title'] ?? '',
      picture: json['picture'],
    );
  }

}

class City {
  final int id;
  final String title;

  City({
    required this.id,
    required this.title,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      title: json['title'] ?? '',
    );
  }

}

class Feature {
  final int id;
  final String title;
  final String icon;
  final String? description;
  final bool isPaid;
  final bool isPopular;

  Feature({
    required this.id,
    required this.title,
    required this.icon,
    this.description,
    required this.isPaid,
    required this.isPopular,
  });

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      id: json['id'],
      title: json['title'] ?? '',
      icon: json['icon'],
      description: json['description'],
      isPaid: json['is_paid'] ?? false,
      isPopular: json['is_popular'] ?? false,
    );
  }

}

class Picture {
  final int id;
  final String picture;
  final bool isMain;

  Picture({
    required this.id,
    required this.picture,
    required this.isMain,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      id: json['id'],
      picture: json['picture'] ?? '',
      isMain: json['is_main'] ?? false,
    );
  }
}
