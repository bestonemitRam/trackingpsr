import 'package:bmitserp/data/source/network/model/projectdashboard/AssignedTask.dart';
import 'package:bmitserp/data/source/network/model/projectdashboard/Progres.dart';
import 'package:bmitserp/data/source/network/model/projectdashboard/Project.dart';

class Data {
  List<AssignedTask> assigned_task;
  Progres progress;
  List<Project> projects;

  Data(
      {required this.assigned_task,
      required this.progress,
      required this.projects});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      assigned_task: (json['assigned_task'] as List)
          .map((i) => AssignedTask.fromJson(i))
          .toList(),
      progress: Progres.fromJson(json['progress']),
      projects:
          (json['projects'] as List).map((i) => Project.fromJson(i)).toList(),
    );
  }
}
