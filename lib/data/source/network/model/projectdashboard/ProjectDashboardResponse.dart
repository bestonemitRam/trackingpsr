import 'package:bmitserp/data/source/network/model/projectdashboard/Data.dart';

class ProjectDashboardResponse {
  Data data;
  String message;
  bool status;
  int status_code;

  ProjectDashboardResponse(
      {required this.data,
      required this.message,
      required this.status,
      required this.status_code});

  factory ProjectDashboardResponse.fromJson(Map<String, dynamic> json) {
    return ProjectDashboardResponse(
      data: Data.fromJson(json['data']),
      message: json['message'],
      status: json['status'],
      status_code: json['status_code'],
    );
  }
}
