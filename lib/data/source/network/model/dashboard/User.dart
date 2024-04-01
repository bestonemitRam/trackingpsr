class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.avatar,
    required this.onlineStatus,
  });

  factory User.fromJson(dynamic json) {
    return User(
        id: json['id'],
        name: json['name'].toString() ?? "",
        email: json['email'].toString() ?? "",
        username: json['username'].toString() ?? "",
        avatar: json['avatar'].toString() ?? "",
        onlineStatus: json['online_status'] ?? false);
  }

  int id;
  String name;
  String email;
  String username;
  String avatar;
  bool onlineStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['username'] = username;
    map['avatar'] = avatar;
    map['online_status'] = onlineStatus;
    return map;
  }
}
