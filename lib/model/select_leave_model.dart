class SelectLeaveTypeModel 
{
  bool? status;
  String? message;
  Result? result;

  SelectLeaveTypeModel({this.status, this.message, this.result});

  SelectLeaveTypeModel.fromJson(Map<String, dynamic> json) {
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
  List<LeaveTypes>? leaveTypes;

  Result({this.leaveTypes});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['leave_types'] != null) {
      leaveTypes = <LeaveTypes>[];
      json['leave_types'].forEach((v) {
        leaveTypes!.add(new LeaveTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leaveTypes != null) {
      data['leave_types'] = this.leaveTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveTypes {
  int? id;
  String? leaveTypeName;

  LeaveTypes({this.id, this.leaveTypeName});

  LeaveTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leaveTypeName = json['leave_type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leave_type_name'] = this.leaveTypeName;
    return data;
  }
}

