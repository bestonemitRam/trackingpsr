class IssueLeaveResponse {
  IssueLeaveResponse({
    required this.status,
    required this.message,
  });

  factory IssueLeaveResponse.fromJson(dynamic json) {
    return IssueLeaveResponse(
      status: json['status'],
      message: json['message'],
    );
  }

  bool status;
  dynamic message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;

    return map;
  }
}
