import '../tasklistresponse/Data.dart';

class tasklistresponse {
  List<Data> data;
  int code;
  bool status;

  tasklistresponse(
      {required this.data, required this.code, required this.status});

  factory tasklistresponse.fromJson(Map<String, dynamic> json) {
    return tasklistresponse(
      data: (json['data'] as List).map((i) => Data.fromJson(i)).toList(),
      code: json['code'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    return data;
  }
}
