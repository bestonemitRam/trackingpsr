// import 'AttendanceStatus.dart';

// class AttendanceStatusResponse {
//   AttendanceStatusResponse({
//     required this.message,
//     required this.status,
//     required this.statusCode,
//     required this.data,
//   });

//   factory AttendanceStatusResponse.fromJson(dynamic json) {
//     AttendanceStatus? data = AttendanceStatus(checkInAt:"", checkOutAt: "", productiveTimeInMin: 0);
//     if (json['data'] != null){
//       data = AttendanceStatus.fromJson(json['data']);
//     }
//     return AttendanceStatusResponse(
//       message: json['message'],
//       status: json['status'],
//       statusCode: json['statusCode'],
//       data: data,
//     );
//   }

//   bool status;
//   dynamic message;
//   int statusCode;
//AttendanceStatus data;
//   Map<String, dynamic>? toJson() {
//     final map = <String, dynamic>{};
//     map['message'] = message;
//     map['status'] = status;
//     map['statusCode'] = statusCode;
//     map['data'] = data.toJson();
//     return map;
//   }
// }

class AttendanceStatusResponse {
  bool? status;
  dynamic message;
  AttendanceStatus? data;

  AttendanceStatusResponse({this.status, this.message, this.data});

  AttendanceStatusResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? new AttendanceStatus.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AttendanceStatus {
  AttendanceData? attendanceData;

  AttendanceStatus({this.attendanceData});

  AttendanceStatus.fromJson(Map<String, dynamic> json) {
    attendanceData = json['attendance_data'] != null
        ? new AttendanceData.fromJson(json['attendance_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attendanceData != null) {
      data['attendance_data'] = this.attendanceData!.toJson();
    }
    return data;
  }
}

class AttendanceData {
  dynamic punchInTime;
  dynamic punchOutTime;
  dynamic attendanceDate;
  dynamic userId;
  dynamic punchInLatitude;
  dynamic punchInLongitude;
  dynamic attendanceStatus;
  dynamic totalWorkingHours;
  dynamic isActive;
  dynamic createdAt;

  AttendanceData(
      {this.punchInTime,
      this.punchOutTime,
      this.attendanceDate,
      this.userId,
      this.punchInLatitude,
      this.punchInLongitude,
      this.attendanceStatus,
      this.totalWorkingHours,
      this.isActive,
      this.createdAt});

  AttendanceData.fromJson(Map<String, dynamic> json) {
    punchInTime = json['punch_in_time'];
    punchOutTime = json['punch_out_time'];
    attendanceDate = json['attendance_date'];
    userId = json['user_id'];
    punchInLatitude = json['punch_in_latitude'];
    punchInLongitude = json['punch_in_longitude'];
    attendanceStatus = json['attendance_status'];
    totalWorkingHours = json['total_working_hours'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['punch_in_time'] = this.punchInTime;
    data['punch_out_time'] = this.punchOutTime;
    data['attendance_date'] = this.attendanceDate;
    data['user_id'] = this.userId;
    data['punch_in_latitude'] = this.punchInLatitude;
    data['punch_in_longitude'] = this.punchInLongitude;
    data['attendance_status'] = this.attendanceStatus;
    data['total_working_hours'] = this.totalWorkingHours;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    return data;
  }
}
