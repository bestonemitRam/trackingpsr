import 'package:bmitserp/data/source/network/model/tadadetail/Attachments.dart';

class Data {
  Attachments attachments;
  String description;
  String employee;
  int id;
  String remark;
  String status;
  String submitted_date;
  String title;
  String total_expense;
  String verified_by;

  Data(
      {required this.attachments,
      required this.description,
      required this.employee,
      required this.id,
      required this.remark,
      required this.status,
      required this.submitted_date,
      required this.title,
      required this.total_expense,
      required this.verified_by});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      attachments: Attachments.fromJson(json['attachments']),
      description: json['description'],
      employee: json['employee'],
      id: json['id'],
      remark: json['remark'],
      status: json['status'],
      submitted_date: json['submitted_date'],
      title: json['title'],
      total_expense: json['total_expense'],
      verified_by: json['verified_by'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['employee'] = this.employee;
    data['id'] = this.id;
    data['remark'] = this.remark;
    data['status'] = this.status;
    data['submitted_date'] = this.submitted_date;
    data['title'] = this.title;
    data['total_expense'] = this.total_expense;
    data['verified_by'] = this.verified_by;
    if (this.attachments != null) {
      data['attachments'] = this.attachments.toJson();
    }
    return data;
  }
}
