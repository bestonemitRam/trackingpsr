import 'package:bmitserp/data/source/network/model/commentsaveresponse/MentionedX.dart';
import 'package:bmitserp/data/source/network/model/commentsaveresponse/Reply.dart';

class Data {
  String avatar;
  String created_at;
  String created_by_id;
  String created_by_name;
  String description;
  int id;
  List<MentionedX> mentioned;
  List<Reply> replies;
  String username;

  Data(
      {required this.avatar,
      required this.created_at,
      required this.created_by_id,
      required this.created_by_name,
      required this.description,
      required this.id,
      required this.mentioned,
      required this.replies,
      required this.username});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      avatar: json['avatar'],
      created_at: json['created_at'],
      created_by_id: json['created_by_id'],
      created_by_name: json['created_by_name'],
      description: json['description'],
      id: json['id'],
      mentioned: (json['mentioned'] as List)
          .map((i) => MentionedX.fromJson(i))
          .toList(),
      replies: (json['replies'] as List).map((i) => Reply.fromJson(i)).toList(),
      username: json['username'],
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
    data['username'] = this.username;
    if (this.mentioned != null) {
      data['mentioned'] = this.mentioned.map((v) => v.toJson()).toList();
    }
    if (this.replies != null) {
      data['replies'] = this.replies.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
