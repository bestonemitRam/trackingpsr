import 'Employeeleavecalendar.dart';

class Employeeleavecalendarresponse {
  Employeeleavecalendarresponse({
    required this.status,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory Employeeleavecalendarresponse.fromJson(dynamic json) {
    return Employeeleavecalendarresponse(
      status: json['status'],
      message: json['message'],
      statusCode: json['status_code'],
      data: List<Employeeleavecalendar>.from(
          json['data'].map((x) => Employeeleavecalendar.fromJson(x))),
    );
  }

  bool status;
  String message;
  int statusCode;
  List<Employeeleavecalendar> data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['status_code'] = statusCode;
    map['data'] = data.map((v) => v.toJson()).toList();
    return map;
  }
}
