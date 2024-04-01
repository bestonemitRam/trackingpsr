import 'package:flutter/material.dart';

class LeaveDetail with ChangeNotifier {
  final int id;
  final String name;
  final String leave_from;
  final String leave_to;
  final String requested_date;
  final String authorization;
  final String status;

  LeaveDetail(
      {required this.id,
      required this.name,
      required this.leave_from,
      required this.leave_to,
      required this.requested_date,
      required this.authorization,
      required this.status});
}
