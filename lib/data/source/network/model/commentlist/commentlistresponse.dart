import '../commentlist/Data.dart';

class CommentListResponse {
  List<Data> data;
  int code;
  bool status;

  CommentListResponse(
      {required this.data, required this.code, required this.status});

  factory CommentListResponse.fromJson(Map<String, dynamic> json) {
    return CommentListResponse(
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