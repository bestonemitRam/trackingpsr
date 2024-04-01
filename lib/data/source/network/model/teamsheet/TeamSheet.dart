import 'Employee.dart';

class TeamSheet {
  TeamSheet({
    required this.id,
    required this.name,
    required this.employee,
  });

  factory TeamSheet.fromJson(dynamic json) {
    return TeamSheet(
        id: json['id'],
        name: json['name'].toString(),
        employee: List<Employee>.from(
            json['employee'].map((x) => Employee.fromJson(x))));
  }

  int id;
  String name;
  List<Employee> employee;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['employee'] = employee.map((v) => v.toJson()).toList();
    return map;
  }
}
