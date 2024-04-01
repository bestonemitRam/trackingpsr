import 'package:flutter/material.dart';

class LeaveByDay with ChangeNotifier {
  String id;
  String name;
  String post;
  String days;
  String avatar;

  LeaveByDay(
      {required this.id,
      required this.name,
      required this.post,
      required this.days,
      required this.avatar});
}
