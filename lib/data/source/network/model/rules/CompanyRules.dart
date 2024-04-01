class CompanyRules {
  CompanyRules({
      required this.title,
      required this.contentType,
      required this.description,});

  factory CompanyRules.fromJson(dynamic json) {
    return CompanyRules(
        title : json['title'].toString() ?? "",
        contentType : json['content_type'].toString() ?? "",
        description : json['description'].toString() ?? "",
    );
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