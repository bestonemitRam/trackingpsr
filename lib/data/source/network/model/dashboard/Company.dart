class Company {
  Company({
    required this.id,
    required this.name,
    required this.weekend,});

  factory Company.fromJson(dynamic json) {
    return Company(
        id: json['id'],
        name: json['name'].toString() ?? "",
        weekend: json['weekend']
    );
  }

  int id;
  String name;
  List<dynamic> weekend;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['weekend'] = weekend;
    return map;
  }

}