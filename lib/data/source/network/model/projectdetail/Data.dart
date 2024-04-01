import 'package:bmitserp/data/source/network/model/projectdetail/AssignedMember.dart';
import 'package:bmitserp/data/source/network/model/projectdetail/AssignedTaskDetail.dart';
import 'package:bmitserp/data/source/network/model/projectdetail/Attachment.dart';
import 'package:bmitserp/data/source/network/model/projectdetail/ProjectLeader.dart';

class Data {
  List<AssignedMember> assigned_member;
  int assigned_task_count;
  List<AssignedTaskDetail> assigned_task_detail;
  List<Attachment> attachments;
  String client_name;
  String cover_pic;
  String deadline;
  String description;
  int id;
  String name;
  String priority;
  int progress_percent;
  List<ProjectLeader> project_leader;
  String start_date;
  String status;

  Data(
      {required this.assigned_member,
      required this.assigned_task_count,
      required this.assigned_task_detail,
      required this.attachments,
      required this.client_name,
      required this.cover_pic,
      required this.deadline,
      required this.description,
      required this.id,
      required this.name,
      required this.priority,
      required this.progress_percent,
      required this.project_leader,
      required this.start_date,
      required this.status});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      assigned_member: (json['assigned_member'] as List)
          .map((i) => AssignedMember.fromJson(i))
          .toList(),
      assigned_task_count: json['assigned_task_count'],
      assigned_task_detail: (json['assigned_task_detail'] as List)
          .map((i) => AssignedTaskDetail.fromJson(i))
          .toList(),
      attachments: (json['attachments'] as List)
          .map((i) => Attachment.fromJson(i))
          .toList(),
      client_name: json['client_name'],
      cover_pic: json['cover_pic'],
      deadline: json['deadline'],
      description: json['description'],
      id: json['id'],
      name: json['name'],
      priority: json['priority'],
      progress_percent: json['progress_percent'],
      project_leader: (json['project_leader'] as List)
          .map((i) => ProjectLeader.fromJson(i))
          .toList(),
      start_date: json['start_date'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assigned_task_count'] = this.assigned_task_count;
    data['client_name'] = this.client_name;
    data['cover_pic'] = this.cover_pic;
    data['deadline'] = this.deadline;
    data['description'] = this.description;
    data['id'] = this.id;
    data['name'] = this.name;
    data['priority'] = this.priority;
    data['progress_percent'] = this.progress_percent;
    data['start_date'] = this.start_date;
    data['status'] = this.status;
    if (this.assigned_member != null) {
      data['assigned_member'] =
          this.assigned_member.map((v) => v.toJson()).toList();
    }
    if (this.assigned_task_detail != null) {
      data['assigned_task_detail'] =
          this.assigned_task_detail.map((v) => v.toJson()).toList();
    }
    if (this.attachments != null) {
      data['attachments'] = this.attachments.map((v) => v.toJson()).toList();
    }
    if (this.project_leader != null) {
      data['project_leader'] =
          this.project_leader.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
