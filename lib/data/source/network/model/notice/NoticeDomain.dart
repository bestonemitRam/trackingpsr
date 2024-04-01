class NoticeDomain {
  NoticeDomain({
    required this.id,
    required this.noticeTitle,
    required this.description,
    required this.noticePublishedDate,
  });

  factory NoticeDomain.fromJson(dynamic json) {
    return NoticeDomain(
      id: json['id'],
      noticeTitle: json['notice_title'].toString() ?? "",
      description: json['description'].toString() ?? "",
      noticePublishedDate: json['notice_published_date'].toString() ?? "",
    );
  }

  int id;
  String noticeTitle;
  String description;
  String noticePublishedDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['notice_title'] = noticeTitle;
    map['description'] = description;
    map['notice_published_date'] = noticePublishedDate;
    return map;
  }
}
