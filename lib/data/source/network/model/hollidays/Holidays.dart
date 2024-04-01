class Holidays {
  Holidays({
    required this.id,
    required this.event,
    required this.eventDate,
    required this.description,
  });

  factory Holidays.fromJson(dynamic json)
   {
    return Holidays(
      id: json['id'],
      event: json['event'].toString() ?? "",
      eventDate: json['event_date'].toString() ?? "",
      description: json['description'].toString() ?? "",
    );
  }

  int id;
  String event;
  String eventDate;
  String description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['event'] = event;
    map['event_date'] = eventDate;
    map['description'] = description;
    return map;
  }
}
