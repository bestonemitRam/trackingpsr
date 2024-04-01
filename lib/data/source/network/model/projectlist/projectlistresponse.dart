import 'package:bmitserp/data/source/network/model/projectlist/Data.dart';

class ProjectListResponse {
  List<Data> data;
  int code;
  bool status;

  ProjectListResponse(
      {required this.data, required this.code, required this.status});

  factory ProjectListResponse.fromJson(Map<String, dynamic> json) {
    return ProjectListResponse(
      data: (json['data'] as List).map((i) => Data.fromJson(i)).toList(),
      code: json['code'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
