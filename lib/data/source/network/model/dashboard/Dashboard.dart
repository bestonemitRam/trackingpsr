import 'User.dart';
import 'EmployeeTodayAttendance.dart';
import 'Overview.dart';
import 'OfficeTime.dart';
import 'Company.dart';

class Dashboard {
  Dashboard({
    required this.user,
    required this.employeeTodayAttendance,
    required this.overview,
    required this.officeTime,
    required this.company,
    required this.employeeWeeklyReport,
    required this.shift_dates,
  });

  factory Dashboard.fromJson(dynamic json) {
    return Dashboard(
        user: User.fromJson(json['user']),
        employeeTodayAttendance: EmployeeTodayAttendance.fromJson(json['employee_today_attendance']),
        overview: Overview.fromJson(json['overview']),
        officeTime: OfficeTime.fromJson(json['office_time']),
        company: Company.fromJson(json['company']),
        employeeWeeklyReport : json['employee_weekly_report'],
        shift_dates : List.from(json['shift_dates'])
    );
  }

  User user;
  EmployeeTodayAttendance employeeTodayAttendance;
  Overview overview;
  OfficeTime officeTime;
  Company company;
  List<dynamic> employeeWeeklyReport;
  List<String> shift_dates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user'] = user.toJson();
    map['employee_today_attendance'] = employeeTodayAttendance.toJson();
    map['overview'] = overview.toJson();
    map['office_time'] = officeTime.toJson();
    map['company'] = company.toJson();
    map['employee_weekly_report'] =
        employeeWeeklyReport.map((v) => v.toJson()).toList();
    return map;
  }
}
