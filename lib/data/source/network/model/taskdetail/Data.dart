import 'package:bmitserp/data/source/network/model/taskdetail/AssignedMember.dart';
import 'package:bmitserp/data/source/network/model/taskdetail/Attachment.dart';
import 'package:bmitserp/data/source/network/model/taskdetail/Checklists.dart';
import 'package:bmitserp/data/source/network/model/taskdetail/TaskComment.dart';

class Data {
  List<AssignedMember> assigned_member;
  List<Attachment> attachments;
  List<Checklists> checklists;
  String deadline;
  String description;
  String priority;
  String project_name;
  String start_date;
  String status;
  List<TaskComment> task_comments;
  int task_id;
  String task_name;
  bool has_checklist;
  int task_progress_percent;

  Data(
      {required this.assigned_member,
      required this.attachments,
      required this.checklists,
      required this.deadline,
      required this.description,
      required this.priority,
      required this.project_name,
      required this.start_date,
      required this.status,
      required this.task_comments,
      required this.task_id,
      required this.task_name,
      required this.has_checklist,
      required this.task_progress_percent});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      assigned_member: (json['assigned_member'] as List)
          .map((i) => AssignedMember.fromJson(i))
          .toList(),
      attachments: (json['attachments'] as List)
          .map((i) => Attachment.fromJson(i))
          .toList(),
      checklists: (json['checklists'] as List)
          .map((i) => Checklists.fromJson(i))
          .toList(),
      deadline: json['deadline'],
      description: json['description'],
      priority: json['priority'],
      project_name: json['project_name'],
      start_date: json['start_date'],
      status: json['status'],
      task_comments: (json['task_comments'] as List)
          .map((i) => TaskComment.fromJson(i))
          .toList(),
      task_id: json['task_id'],
      task_name: json['task_name'],
      has_checklist: json['has_checklist'],
      task_progress_percent: json['task_progress_percent'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deadline'] = this.deadline;
    data['description'] = this.description;
    data['priority'] = this.priority;
    data['project_name'] = this.project_name;
    data['start_date'] = this.start_date;
    data['status'] = this.status;
    data['task_id'] = this.task_id;
    data['task_name'] = this.task_name;
    data['task_progress_percent'] = this.task_progress_percent;
    if (this.assigned_member != null) {
      data['assigned_member'] =
          this.assigned_member.map((v) => v.toJson()).toList();
    }
    if (this.attachments != null) {
      data['attachments'] = this.attachments.map((v) => v.toJson()).toList();
    }
    if (this.checklists != null) {
      data['checklists'] = this.checklists.map((v) => v.toJson()).toList();
    }
    if (this.task_comments != null) {
      data['task_comments'] =
          this.task_comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
