import 'NotifiactionDomain.dart';

class NotificationResponse {
  NotificationResponse({
    required this.data,
    required this.status,
    required this.statusCode,
  });

  factory NotificationResponse.fromJson(dynamic json) {
    return NotificationResponse(
        status: json['status'],
        statusCode: json['status_code'],
        data: List<NotifiactionDomain>.from(
            json['data'].map((x) => NotifiactionDomain.fromJson(x))));
  }

  List<NotifiactionDomain> data;
  bool status;
  int statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data.map((v) => v.toJson()).toList();
    map['status'] = status;
    map['status_code'] = statusCode;
    return map;
  }
}
