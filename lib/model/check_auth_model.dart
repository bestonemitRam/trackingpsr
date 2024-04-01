class CheckAuthModel {
  bool? status;
  String? message;
  ResultData? result;

  CheckAuthModel({this.status, this.message, this.result});

  CheckAuthModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? new ResultData.fromJson(json['result']) : null;
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

class ResultData {
  UserDatas? userData;
  String? userToken;
  int? active_status;

  ResultData({this.userData, this.userToken});

  ResultData.fromJson(Map<String, dynamic> json) {
    userData = json['userData'] != null
        ? new UserDatas.fromJson(json['userData'])
        : null;
    userToken = json['user_token'];
    active_status = json['active_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userData != null) {
      data['userData'] = this.userData!.toJson();
    }
    data['user_token'] = this.userToken;
    data['active_status'] = this.active_status;
    return data;
  }
}

class UserDatas {
  int? id;
  String? fullName;
  String? mail;
  String? contact;
  String? gender;
  String? dob;
  String? userToken;

  UserDatas(
      {this.id,
      this.fullName,
      this.mail,
      this.contact,
      this.gender,
      this.dob,
      this.userToken});

  UserDatas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    mail = json['mail'];
    contact = json['contact'];
    gender = json['gender'];
    dob = json['dob'];
    userToken = json['user_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['mail'] = this.mail;
    data['contact'] = this.contact;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['user_token'] = this.userToken;
    return data;
  }
}
