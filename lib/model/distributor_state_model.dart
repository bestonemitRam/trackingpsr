
class HomePageModel {
  bool? status;
  String? message;
  HomePagedata? result;

  HomePageModel({this.status, this.message, this.result});

  HomePageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result = json['result'] != null
        ? new HomePagedata.fromJson(json['result'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class HomePagedata {
  int? totalDistributors;
  int? totalRetailers;

  HomePagedata({this.totalDistributors, this.totalRetailers});

  HomePagedata.fromJson(Map<String, dynamic> json) {
    totalDistributors = json['totalDistributors'];
    totalRetailers = json['totalRetailers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalDistributors'] = this.totalDistributors;
    data['totalRetailers'] = this.totalRetailers;
    return data;
  }
}
