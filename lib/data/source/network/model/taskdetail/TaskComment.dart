import 'package:bmitserp/data/source/network/model/taskdetail/Mentioned.dart';

class TaskComment {
  String avatar;
  String created_at;
  String created_by_id;
  String created_by_name;
  String description;
  int id;
  List<Mentioned> mentioned;

  TaskComment(
      {required this.avatar,
      required this.created_at,
      required this.created_by_id,
      required this.created_by_name,
      required this.description,
      required this.id,
      required this.mentioned});

  factory TaskComment.fromJson(Map<String, dynamic> json) {
    return TaskComment(
      avatar: json['avatar'],
      created_at: json['created_at'],
      created_by_id: json['created_by_id'],
      created_by_name: json['created_by_name'],
      description: json['description'],
      id: json['id'],
      mentioned: (json['mentioned'] as List)
          .map((i) => Mentioned.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['created_at'] = this.created_at;
    data['created_by_id'] = this.created_by_id;
    data['created_by_name'] = this.created_by_name;
    data['description'] = this.description;
    data['id'] = this.id;
    if (this.mentioned != null) {
      data['mentioned'] = this.mentioned.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
