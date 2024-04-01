import '../departmentlistresponse/Data.dart';

class departmentlistresponse {
  List<Data> data;
  String message;
  bool status;
  int status_code;

  departmentlistresponse(
      {required this.data,
      required this.message,
      required this.status,
      required this.status_code});

  factory departmentlistresponse.fromJson(Map<String, dynamic> json) {
    return departmentlistresponse(
      data: (json['data'] as List).map((i) => Data.fromJson(i)).toList(),
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
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
