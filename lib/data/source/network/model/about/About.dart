class About {
  About({
    required this.title,
    required this.contentType,
    required this.description,
  });

  factory About.fromJson(dynamic json) {
    return About(
        title: json['title'].toString() ?? "",
        contentType: json['content_type'].toString() ?? "",
        description: json['description'].toString() ?? "");
  }

  String title;
  String contentType;
  String description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['content_type'] = contentType;
    map['description'] = description;
    return map;
  }
}
