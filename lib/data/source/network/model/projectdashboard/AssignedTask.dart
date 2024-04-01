import 'package:bmitserp/data/source/network/model/projectdashboard/AssignedMemberX.dart';

class AssignedTask {
  List<AssignedMemberX> assigned_member;
  String end_date;
  String priority;
  String project_name;
  String start_date;
  String status;
  int task_id;
  String task_name;

  AssignedTask(
      {required this.assigned_member,
      required this.end_date,
      required this.priority,
      required this.project_name,
      required this.start_date,
      required this.status,
      required this.task_id,
      required this.task_name});

  factory AssignedTask.fromJson(Map<String, dynamic> json) {
    return AssignedTask(
      assigned_member: (json['assigned_member'] as List)
          .map((i) => AssignedMemberX.fromJson(i))
          .toList(),
      end_date: json['end_date'],
      priority: json['priority'],
      project_name: json['project_name'],
      start_date: json['start_date'],
      status: json['status'],
      task_id: json['task_id'],
      task_name: json['task_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['end_date'] = this.end_date;
    data['priority'] = this.priority;
    data['project_name'] = this.project_name;
    data['start_date'] = this.start_date;
    data['status'] = this.status;
    data['task_id'] = this.task_id;
    data['task_name'] = this.task_name;
    if (this.assigned_member != null) {
      data['assigned_member'] =
          this.assigned_member.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
