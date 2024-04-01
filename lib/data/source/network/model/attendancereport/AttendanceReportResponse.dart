// import 'Data.dart';

// class AttendanceReportResponse {
//   AttendanceReportResponse({
//       required this.status,
//       required this.message,
//       required this.statusCode,
//       required this.data,});

//   factory AttendanceReportResponse.fromJson(dynamic json) {
//     return AttendanceReportResponse(
//       status : json['status'],
//       message : json['message'],
//       statusCode : json['status_code'],
//       data : Data.fromJson(json['data']),
//     );
//   }
//   bool status;
//   String message;
//   int statusCode;
//   Data data;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['message'] = message;
//     map['status_code'] = statusCode;
//     map['data'] = data.toJson();
//     return map;
//   }

// }

class AttendanceReportResponse {
  bool? status;
  dynamic message;
  Result? result;

  AttendanceReportResponse({this.status, this.message, this.result});

  AttendanceReportResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
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

class Result {
  List<AttendanceList>? attendanceList;

  Result({this.attendanceList});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['attendance_list'] != null) {
      attendanceList = <AttendanceList>[];
      json['attendance_list'].forEach((v) {
        attendanceList!.add(new AttendanceList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attendanceList != null) {
      data['attendance_list'] =
          this.attendanceList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttendanceList {
  int? id;
  dynamic punchInTime;
  dynamic punchOutTime;
  dynamic attendanceDate;
  dynamic attendanceStatus;
  dynamic totalWorkingHours;

  AttendanceList(
      {this.id,
      this.punchInTime,
      this.punchOutTime,
      this.attendanceDate,
      this.attendanceStatus,
      this.totalWorkingHours});

  AttendanceList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    punchInTime = json['punch_in_time'];
    punchOutTime = json['punch_out_time'];
    attendanceDate = json['attendance_date'];
    attendanceStatus = json['attendance_status'];
    totalWorkingHours = json['total_working_hours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['punch_in_time'] = this.punchInTime;
    data['punch_out_time'] = this.punchOutTime;
    data['attendance_date'] = this.attendanceDate;
    data['attendance_status'] = this.attendanceStatus;
    data['total_working_hours'] = this.totalWorkingHours;
    return data;
  }
}
