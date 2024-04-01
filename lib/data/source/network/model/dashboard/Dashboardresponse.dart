import 'Dashboard.dart';

class Dashboardresponse {
  Dashboardresponse({
    required this.status,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory Dashboardresponse.fromJson(dynamic json) {
    return Dashboardresponse(
        status: json['status'],
        message : json['message'],
        statusCode : json['status_code'],
        data : Dashboard.fromJson(json['data'])
    );
  }

  bool status;
  String message;
  int statusCode;
  Dashboard data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['status_code'] = statusCode;
    map['data'] = data.toJson();
    return map;
  }
}
