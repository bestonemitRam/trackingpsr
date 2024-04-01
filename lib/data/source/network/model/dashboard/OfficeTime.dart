class OfficeTime {
  OfficeTime({
    required this.id,
    required this.startTime,
    required this.endTime,
  });

  factory OfficeTime.fromJson(dynamic json) {
    return OfficeTime(
        id: json['id'],
        startTime: json['start_time'].toString() ?? "",
        endTime: json['end_time'].toString() ?? "");
  }

  int id;
  String startTime;
  String endTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    return map;
  }
}
