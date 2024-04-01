import 'package:bmitserp/data/source/network/model/commentsaveresponse/MentionedX.dart';

class Reply {
  String avatar;
  String comment_id;
  String created_at;
  String created_by_id;
  String created_by_name;
  String description;
  List<MentionedX> mentioned;
  int reply_id;
  String username;

  Reply(
      {required this.avatar,
      required this.comment_id,
      required this.created_at,
      required this.created_by_id,
      required this.created_by_name,
      required this.description,
      required this.mentioned,
      required this.reply_id,
      required this.username});

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      avatar: json['avatar'],
      comment_id: json['comment_id'],
      created_at: json['created_at'],
      created_by_id: json['created_by_id'],
      created_by_name: json['created_by_name'],
      description: json['description'],
      mentioned: (json['mentioned'] as List)
          .map((i) => MentionedX.fromJson(i))
          .toList(),
      reply_id: json['reply_id'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['comment_id'] = this.comment_id;
    data['created_at'] = this.created_at;
    data['created_by_id'] = this.created_by_id;
    data['created_by_name'] = this.created_by_name;
    data['description'] = this.description;
    data['reply_id'] = this.reply_id;
    data['username'] = this.username;
    if (this.mentioned != null) {
      data['mentioned'] = this.mentioned.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
