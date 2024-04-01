
class ProfileUserModel {
  String? message;
  bool? status;
  int? statusCode;
  Data? data;

  ProfileUserModel({this.message, this.status, this.statusCode, this.data});

  ProfileUserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  ProfileDatas? profileData;

  Data({this.profileData});

  Data.fromJson(Map<String, dynamic> json) {
    profileData = json['ProfileData'] != null
        ? new ProfileDatas.fromJson(json['ProfileData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profileData != null) {
      data['ProfileData'] = this.profileData!.toJson();
    }
    return data;
  }
}

class ProfileDatas {
  int? userId;
  String? fullName;
  String? mail;
  String? contact;
  String? dob;
  String? gender;
  String? avatar;

  ProfileDatas(
      {this.userId,
      this.fullName,
      this.mail,
      this.contact,
      this.dob,
      this.gender,
      this.avatar});

  ProfileDatas.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullName = json['full_name'];
    mail = json['mail'];
    contact = json['contact'];
    dob = json['dob'];
    gender = json['gender'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['full_name'] = this.fullName;
    data['mail'] = this.mail;
    data['contact'] = this.contact;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['avatar'] = this.avatar;
    return data;
  }
}
