// import 'Profile.dart';

// class Profileresponse
//  {
//   Profileresponse({
//     required this.status,
//     required this.message,
//     required this.statusCode,
//     required this.data,
//   });

//   factory Profileresponse.fromJson(dynamic json) {
//     return Profileresponse(
//         status: json['status'],
//         message: json['message'],
//         statusCode: json['status_code'],
//         data: Profile.fromJson(json['data'] ?? []));
//   }

//   bool status;
//   String message;
//   int statusCode;
//   Profile data;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['message'] = message;
//     map['status_code'] = statusCode;
//     map['data'] = data.toJson();
//     return map;
//   }
// }
class Profileresponse {
  String? message;
  bool? status;
  int? statusCode;
  Data? data;

  Profileresponse({this.message, this.status, this.statusCode, this.data});

  Profileresponse.fromJson(Map<String, dynamic> json) {
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
  ProfileData? profileData;

  Data({this.profileData});

  Data.fromJson(Map<String, dynamic> json) {
    profileData = json['ProfileData'] != null
        ? new ProfileData.fromJson(json['ProfileData'])
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

class ProfileData {
  int? userId;
  String? fullName;
  String? mail;
  String? contact;
  String? dob;
  String? gender;
  String? avatar;

  ProfileData(
      {this.userId,
      this.fullName,
      this.mail,
      this.contact,
      this.dob,
      this.gender,
      this.avatar});

  ProfileData.fromJson(Map<String, dynamic> json) {
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
