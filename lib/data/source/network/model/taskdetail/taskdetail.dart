import '../taskdetail/Data.dart';

class TaskDetailResponse {
  Data data;
  String message;
  bool status;
  int status_code;

  TaskDetailResponse(
      {required this.data,
      required this.message,
      required this.status,
      required this.status_code});

  factory TaskDetailResponse.fromJson(Map<String, dynamic> json) {
    return TaskDetailResponse(
      data: Data.fromJson(json['data']),
      message: json['message'],
      status: json['status'],
      status_code: json['status_code'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['status_code'] = this.status_code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}
