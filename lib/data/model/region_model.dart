class RegionModel {
  final int id;
  final String title;

  RegionModel({
    required this.id,
    required this.title,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
      id: json['id'],
      title: json['title'],
    );
  }

}
