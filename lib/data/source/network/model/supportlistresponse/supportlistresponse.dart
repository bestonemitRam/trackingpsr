import '../supportlistresponse/Data.dart';

class supportlistresponse {
  Data data;
  String message;
  bool status;
  int status_code;

  supportlistresponse(
      {required this.data,
      required this.message,
      required this.status,
      required this.status_code});

  factory supportlistresponse.fromJson(Map<String, dynamic> json) {
    return supportlistresponse(
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
