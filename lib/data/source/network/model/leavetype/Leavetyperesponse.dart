

// class Leavetyperesponse {
//   String? message;
//   bool? status;
//   int? statusCode;
//   Data? data;

//   Leavetyperesponse({this.message, this.status, this.statusCode, this.data});

//   Leavetyperesponse.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     status = json['status'];
//     statusCode = json['statusCode'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     data['status'] = this.status;
//     data['statusCode'] = this.statusCode;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class Data {
//   List<LeaveType>? leaveTypeData;

//   Data({this.leaveTypeData});

//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['leaveTypeData'] != null) {
//       leaveTypeData = <LeaveType>[];
//       json['leaveTypeData'].forEach((v) {
//         leaveTypeData!.add(new LeaveType.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.leaveTypeData != null) {
//       data['leaveTypeData'] =
//           this.leaveTypeData!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class LeaveType {
//   int? id;
//   String? alloted;
//   String? taken;
//   String? available;
//   String? leaveTypeName;

//   LeaveType(
//       {this.id, this.alloted, this.taken, this.available, this.leaveTypeName});

//   LeaveType.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     alloted = json['alloted'];
//     taken = json['taken'];
//     available = json['available'];
//     leaveTypeName = json['leave_type_name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['alloted'] = this.alloted;
//     data['taken'] = this.taken;
//     data['available'] = this.available;
//     data['leave_type_name'] = this.leaveTypeName;
//     return data;
//   }
// }

class Leavetyperesponse {
  bool? status;
  String? message;
  Data? result;

  Leavetyperesponse({this.status, this.message, this.result});

  Leavetyperesponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? new Data.fromJson(json['result']) : null;
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

class Data {
  List<LeavesData>? leavesData;

  Data({this.leavesData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['leaves_data'] != null) {
      leavesData = <LeavesData>[];
      json['leaves_data'].forEach((v) {
        leavesData!.add(new LeavesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leavesData != null) {
      data['leaves_data'] = this.leavesData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeavesData {
  String? alloted;
  String? taken;
  String? available;
  String? leaveTypeName;

  LeavesData({this.alloted, this.taken, this.available, this.leaveTypeName});

  LeavesData.fromJson(Map<String, dynamic> json) {
    alloted = json['alloted'];
    taken = json['taken'];
    available = json['available'];
    leaveTypeName = json['leave_type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alloted'] = this.alloted;
    data['taken'] = this.taken;
    data['available'] = this.available;
    data['leave_type_name'] = this.leaveTypeName;
    return data;
  }
}

