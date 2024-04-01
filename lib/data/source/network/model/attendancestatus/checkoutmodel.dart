class CheckOutModel {
  bool? status;
  dynamic message;
  CheckOutData? result;

  CheckOutModel({this.status, this.message, this.result});

  CheckOutModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? new CheckOutData.fromJson(json['result']) : null;
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

class CheckOutData {
  AttendanceData? attendanceData;

  CheckOutData({this.attendanceData});

  CheckOutData.fromJson(Map<String, dynamic> json) {
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
  int? id;
  dynamic punchInTime;
  dynamic punchOutTime;
  dynamic attendanceDate;
  dynamic attendanceStatus;
  dynamic totalWorkingHours;

  AttendanceData(
      {this.id,
      this.punchInTime,
      this.punchOutTime,
      this.attendanceDate,
      this.attendanceStatus,
      this.totalWorkingHours});

  AttendanceData.fromJson(Map<String, dynamic> json) {
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
