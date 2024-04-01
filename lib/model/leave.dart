import 'package:flutter/material.dart';

class Leave with ChangeNotifier {
  int id;
  String name;
  int allocated;
  int total;
  bool status;
  bool isEarlyLeave;

  Leave(
      {required this.id,
      required this.name,
      required this.allocated,
      required this.total,
      required this.status,
      required this.isEarlyLeave});
}
