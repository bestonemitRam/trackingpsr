class UserDetail {
  UserDetail({
      required this.userId,
      required this.name,
      required this.email,});

  factory UserDetail.fromJson(dynamic json) {
    return UserDetail(
        userId : json['user_id'],
        name : json['name'].toString() ?? "",
        email : json['email'].toString() ?? ""
    );
  }
  int userId;
  String name;
  String email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['name'] = name;
    map['email'] = email;
    return map;
  }

}