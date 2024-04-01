import 'NoticeDomain.dart';

class NoticeResponse {
  NoticeResponse({
    required this.data,
    required this.status,
    required this.statusCode,
  });

  factory NoticeResponse.fromJson(dynamic json) {
    return NoticeResponse(
        status: json['status'],
        statusCode: json['status_code'],
        data: List<NoticeDomain>.from(
            json['data'].map((x) => NoticeDomain.fromJson(x))));
  }

  List<NoticeDomain> data;
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
