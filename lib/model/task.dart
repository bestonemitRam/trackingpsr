import 'package:bmitserp/model/attachment.dart';
import 'package:bmitserp/model/checklist.dart';
import 'package:bmitserp/model/member.dart';

class Task {
  int? id;
  String? name;
  String? projectName;
  String? description;
  String? date;
  String? endDate;
  String? priority;
  String? status;
  int? progress;
  int? noOfComments;
  bool? has_checklist;
  List<Member> members = [];
  List<Checklist> checkList = [];
  List<Attachment> attachments = [];

  Task.all(
      this.id,
      this.name,
      this.projectName,
      this.description,
      this.date,
      this.endDate,
      this.priority,
      this.status,
      this.progress,
      this.noOfComments,
      this.has_checklist,
      this.members,
      this.checkList,
      this.attachments);

  Task(this.id, this.name, this.projectName, this.date, this.endDate,
      this.status);
}
