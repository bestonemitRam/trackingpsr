// import 'Login.dart';

// class Loginresponse {

//   Loginresponse({
//     required this.status,
//     required this.message,
//     required this.statusCode,
//     required this.data,
//   });

//   factory Loginresponse.fromJson(dynamic json) {
//     return Loginresponse(
//         status: json['status'],
//         message: json['message'],
//         statusCode: json['statusCode'],
//         data: Login.fromJson(json['data']));
//   }


//   bool status;
//   String message;
//   int statusCode;
//   Login data;


//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['message'] = message;
//     map['statusCode'] = statusCode;
//     map['data'] = data.toJson();
//     return map;
//   }
// }


class Loginresponse {
  dynamic message;
  bool? status;
  Result? result;

  Loginresponse({this.message, this.status, this.result});

  Loginresponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  User? user;
  dynamic tokens;

  Result({this.user, this.tokens});

  Result.fromJson(Map<String, dynamic> json) 
  {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    tokens = json['tokens'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['tokens'] = this.tokens;
    return data;
  }
}

class User {
  int? id;
  dynamic employeeCode;
  dynamic fullName;
  dynamic mail;
  dynamic contact;
  dynamic gender;
  dynamic dob;
  dynamic avatar;

  User(
      {this.id,
      this.employeeCode,
      this.fullName,
      this.mail,
      this.contact,
      this.gender,
      this.dob,
      this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeCode = json['employee_code'];
    fullName = json['full_name'];
    mail = json['mail'];
    contact = json['contact'];
    gender = json['gender'];
    dob = json['dob'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_code'] = this.employeeCode;
    data['full_name'] = this.fullName;
    data['mail'] = this.mail;
    data['contact'] = this.contact;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['avatar'] = this.avatar;
    return data;
  }
}

