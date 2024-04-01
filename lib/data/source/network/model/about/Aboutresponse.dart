import 'About.dart';

class Aboutresponse {
  Aboutresponse({
    required this.status,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory Aboutresponse.fromJson(dynamic json) {
    return Aboutresponse(
        status: json['status'] ?? false,
        message: json['message'] ?? "",
        statusCode: json['status_code'] ?? 400,
        data: About.fromJson(json['data']));
  }

  bool status;
  String message;
  int statusCode;
  About data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['status_code'] = statusCode;
    map['data'] = data.toJson();
    return map;
  }
}
