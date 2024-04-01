import 'EmployeeLeavesByDay.dart';

class EmployeeLeavesByDayResponse {
  EmployeeLeavesByDayResponse({
    required this.status,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory EmployeeLeavesByDayResponse.fromJson(dynamic json) {
    return EmployeeLeavesByDayResponse(
        status: json['status'],
        message: json['message'],
        statusCode: json['status_code'],
        data: List<EmployeeLeavesByDay>.from(
            json['data'].map((x) => EmployeeLeavesByDay.fromJson(x))));
  }

  bool status;
  String message;
  int statusCode;
  List<EmployeeLeavesByDay> data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['status_code'] = statusCode;
    map['data'] = data.map((v) => v.toJson()).toList();
    return map;
  }
}
