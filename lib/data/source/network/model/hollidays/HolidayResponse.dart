// import 'Holidays.dart';

// class HolidayResponse {
//   HolidayResponse({
//     required this.status,
//     required this.message,
//     required this.statusCode,
//     required this.data,
//   });

//   factory HolidayResponse.fromJson(dynamic json) {
//     return HolidayResponse(
//         status: json['status'],
//         message: json['message'],
//         statusCode: json['status_code'],
//         data: List<Holidays>.from(json['data'].map((x) => Holidays.fromJson(x))));
//   }

//   bool status;
//   String message;
//   int statusCode;
//   List<Holidays>? data;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['message'] = message;
//     map['status_code'] = statusCode;
//     map['data'] = data?.map((v) => v.toJson()).toList();
//     return map;
//   }
// }


class HolidayResponse {
  String? message;
  bool? status;
  int? statusCode;
  Data? data;

  HolidayResponse({this.message, this.status, this.statusCode, this.data});

  HolidayResponse.fromJson(Map<String, dynamic> json) {
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
  List<PastHoliday>? pastHoliday;
  List<PastHoliday>? upcomingHoliday;
  PastHoliday? todayHoliday;

  Data({this.pastHoliday, this.upcomingHoliday, this.todayHoliday});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['pastHoliday'] != null) {
      pastHoliday = <PastHoliday>[];
      json['pastHoliday'].forEach((v) {
        pastHoliday!.add(new PastHoliday.fromJson(v));
      });
    }
    if (json['upcomingHoliday'] != null) {
      upcomingHoliday = <PastHoliday>[];
      json['upcomingHoliday'].forEach((v) {
        upcomingHoliday!.add(new PastHoliday.fromJson(v));
      });
    }
    todayHoliday = json['todayHoliday'] != null
        ? new PastHoliday.fromJson(json['todayHoliday'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pastHoliday != null) {
      data['pastHoliday'] = this.pastHoliday!.map((v) => v.toJson()).toList();
    }
    if (this.upcomingHoliday != null) {
      data['upcomingHoliday'] =
          this.upcomingHoliday!.map((v) => v.toJson()).toList();
    }
    if (this.todayHoliday != null) {
      data['todayHoliday'] = this.todayHoliday!.toJson();
    }
    return data;
  }
}

class PastHoliday {
  int? id;
  String? holidayName;
  String? holidayDate;

  PastHoliday({this.id, this.holidayName, this.holidayDate});

  PastHoliday.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    holidayName = json['holiday_name'];
    holidayDate = json['holiday_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['holiday_name'] = this.holidayName;
    data['holiday_date'] = this.holidayDate;
    return data;
  }
}
