class NotifiactionDomain {
  NotifiactionDomain({
    required this.id,
    required this.notificationTitle,
    required this.description,
    required this.notificationPublishedDate,
  });

  factory NotifiactionDomain.fromJson(dynamic json) {
    return NotifiactionDomain(
      id: json['id'],
      notificationTitle: json['notification_title'].toString() ?? "",
      description: json['description'].toString() ?? "",
      notificationPublishedDate: json['notification_published_date'].toString() ?? "",
    );
  }

  int id;
  String notificationTitle;
  String description;
  String notificationPublishedDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['notification_title'] = notificationTitle;
    map['description'] = description;
    map['notification_published_date'] = notificationPublishedDate;
    return map;
  }
}
