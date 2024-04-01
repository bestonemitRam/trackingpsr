import 'UserDetail.dart';
import 'EmployeeTodayAttendance.dart';
import 'EmployeeAttendance.dart';

class Data {
  Data({
    required this.userDetail,
    required this.employeeTodayAttendance,
    required this.employeeAttendance,
  });

  factory Data.fromJson(dynamic json) {
    return Data(
        userDetail: UserDetail.fromJson(json['user_detail']),
        employeeTodayAttendance:
            EmployeeTodayAttendance.fromJson(json['employee_today_attendance']),
        employeeAttendance: List<EmployeeAttendance>.from(
            json['employee_attendance']
                .map((x) => EmployeeAttendance.fromJson(x))));
  }

  UserDetail userDetail;
  EmployeeTodayAttendance employeeTodayAttendance;
  List<EmployeeAttendance> employeeAttendance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_detail'] = userDetail.toJson();
    map['employee_today_attendance'] = employeeTodayAttendance.toJson();
    map['employee_attendance'] =
        employeeAttendance.map((v) => v.toJson()).toList();
    return map;
  }
}
