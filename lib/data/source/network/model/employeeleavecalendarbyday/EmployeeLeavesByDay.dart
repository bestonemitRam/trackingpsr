class EmployeeLeavesByDay {
  EmployeeLeavesByDay({
    required this.leaveId,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.department,
    required this.post,
    required this.leaveDays,
    required this.leaveFrom,
    required this.leaveTo,
    required this.leaveStatus,
  });

  factory EmployeeLeavesByDay.fromJson(dynamic json) {
    return EmployeeLeavesByDay(
      leaveId: json['leave_id'].toString() ?? "",
      userId: json['user_id'].toString() ?? "",
      userName: json['user_name'].toString() ?? "",
      userAvatar: json['user_avatar'].toString() ?? "",
      department: json['department'].toString() ?? "",
      post: json['post'].toString() ?? "",
      leaveDays: json['leave_days'].toString() ?? "",
      leaveFrom: json['leave_from'].toString() ?? "",
      leaveTo: json['leave_to'].toString() ?? "",
      leaveStatus: json['leave_status'].toString() ?? "",
    );
  }

  String leaveId;
  String userId;
  String userName;
  String userAvatar;
  String department;
  String post;
  String leaveDays;
  String leaveFrom;
  String leaveTo;
  String leaveStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['leave_id'] = leaveId;
    map['user_id'] = userId;
    map['user_name'] = userName;
    map['user_avatar'] = userAvatar;
    map['department'] = department;
    map['post'] = post;
    map['leave_days'] = leaveDays;
    map['leave_from'] = leaveFrom;
    map['leave_to'] = leaveTo;
    map['leave_status'] = leaveStatus;
    return map;
  }
}
