class HelpCenterModel {
  final int id;
  final String title;
  final String icon;
  final String link;

  HelpCenterModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.link,
  });
  factory HelpCenterModel.fromJson(Map<String, dynamic> json) {
    return HelpCenterModel(
      id: json['id'] as int,
      title: json['title'] as String,
      icon: json['icon'] as String,
      link: json['link'] as String,
    );
  }
}
