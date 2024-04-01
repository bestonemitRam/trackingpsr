class EmployeeTodayAttendance {
  EmployeeTodayAttendance({
    required this.checkInAt,
    required this.checkOutAt,
    required this.productionTime,
  });

  factory EmployeeTodayAttendance.fromJson(dynamic json) {
    return EmployeeTodayAttendance(
        checkInAt: json['check_in_at'].toString() ?? "",
        checkOutAt: json['check_out_at'].toString() ?? "",
        productionTime: json['productive_time_in_min'] ?? "");
  }

  int productionTime;
  String checkInAt;
  String checkOutAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['check_in_at'] = checkInAt;
    map['check_out_at'] = checkOutAt;
    return map;
  }
}
