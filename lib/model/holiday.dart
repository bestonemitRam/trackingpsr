import 'package:flutter/material.dart';

class Holiday with ChangeNotifier {
  int id;
  String day;
  String month;
  String title;
  String description;
  DateTime dateTime;

  Holiday(
      {required this.id,
      required this.day,
      required this.month,
      required this.title,
      required this.description,
      required this.dateTime});
}
