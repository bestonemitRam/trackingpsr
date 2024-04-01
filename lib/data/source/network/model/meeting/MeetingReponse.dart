import 'MeetingDomain.dart';

class MeetingReponse {
  MeetingReponse({
      required this.data,
      required this.status,
      required this.statusCode,});

  factory MeetingReponse.fromJson(dynamic json) {
    return MeetingReponse(
    status : json['status'],
    statusCode : json['status_code'],
    data: List<MeetingDomain>.from(
    json['data'].map((x) => MeetingDomain.fromJson(x))));
  }
  List<MeetingDomain> data;
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