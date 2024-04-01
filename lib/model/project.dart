import 'package:bmitserp/model/attachment.dart';
import 'package:bmitserp/model/member.dart';
import 'package:bmitserp/model/task.dart';

class Project {
  int id;
  String name;
  String description;
  String date;
  String priority;
  String status;
  int progress;
  int noOfTask;
  List<Member> members;
  List<Member> leaders;
  List<Task> tasks = [];
  List<Attachment> attachment = [];

  Project(
      this.id,
      this.name,
      this.description,
      this.date,
      this.priority,
      this.status,
      this.progress,
      this.noOfTask,
      this.members,
      this.leaders,
      this.attachment);
}
