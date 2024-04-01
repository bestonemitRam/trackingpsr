import 'package:flutter/material.dart';

class EmployeeAttendanceReport with ChangeNotifier {
  int id;
  dynamic attendance_date;
  dynamic total_working_hour;
  dynamic check_in;
  dynamic check_out;

  EmployeeAttendanceReport(
      {required this.id,
      this.attendance_date,
      this.total_working_hour,
      this.check_in,
      this.check_out});
}
