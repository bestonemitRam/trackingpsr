class ProjectLeader {
  String avatar;
  int id;
  String name;
  String post;

  ProjectLeader(
      {required this.avatar,
      required this.id,
      required this.name,
      required this.post});

  factory ProjectLeader.fromJson(Map<String, dynamic> json) {
    return ProjectLeader(
      avatar: json['avatar'],
      id: json['id'],
      name: json['name'],
      post: json['post'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['id'] = this.id;
    data['name'] = this.name;
    data['post'] = this.post;
    return data;
  }
}
