import 'CompanyRules.dart';

class CompanyRulesReponse {
  CompanyRulesReponse({
    required this.status,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory CompanyRulesReponse.fromJson(dynamic json) {
    return CompanyRulesReponse(
        status: json['status'],
        message: json['message'],
        statusCode: json['status_code'],
        data: List<CompanyRules>.from(
            json['data'].map((x) => CompanyRules.fromJson(x))));
  }

  bool status;
  String message;
  int statusCode;
  List<CompanyRules> data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['status_code'] = statusCode;
    map['data'] = data.map((v) => v.toJson()).toList();
    return map;
  }
}
