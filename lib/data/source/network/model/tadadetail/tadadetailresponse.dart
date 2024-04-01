import '../tadadetail/Data.dart';

// class TadaDetailResponse {
//     Data data;
//     dynamic message;
//     bool status;
//     dynamic statusCode;

//     TadaDetailResponse({required this.data,required this.message,required this.status,required this.statusCode});

//     factory TadaDetailResponse.fromJson(Map<dynamic, dynamic> json) {
//         return TadaDetailResponse(
//             data: Data.fromJson(json['data']),
//             message: json['message'],
//             status: json['status'],
//             statusCode: json['statusCode'],
//         );
//     }

//     Map<dynamic, dynamic> toJson() {
//         final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
//         data['message'] = this.message;
//         data['status'] = this.status;
//         data['statusCode'] = this.statusCode;
//         if (this.data != null) {
//             data['data'] = this.data.toJson();
//         }
//         return data;
//     }
// }

// class TadaDetailResponse {
//   dynamic? message;
//   bool? status;
//   dynamic? statusCode;
//   Data? data;

//   TadaDetailResponse({this.message, this.status, this.statusCode, this.data});

//   TadaDetailResponse.fromJson(Map<dynamic, dynamic> json) {
//     message = json['message'];
//     status = json['status'];
//     statusCode = json['statusCode'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }

//   Map<dynamic, dynamic> toJson() {
//     final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
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
//   dynamic? id;
//   dynamic? title;
//   dynamic? totalExpense;
//   dynamic? description;

//   Data({this.id, this.title, this.totalExpense, this.description});

//   Data.fromJson(Map<dynamic, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     totalExpense = json['total_expense'];
//     description = json['description'];
//   }

//   Map<dynamic, dynamic> toJson() {
//     final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['total_expense'] = this.totalExpense;
//     data['description'] = this.description;
//     return data;
//   }
// }

// class TadaDetailResponse {
//   dynamic? message;
//   bool? status;
//   dynamic? statusCode;
//   Data? data;

//   TadaDetailResponse({this.message, this.status, this.statusCode, this.data});

//   TadaDetailResponse.fromJson(Map<dynamic, dynamic> json) {
//     message = json['message'];
//     status = json['status'];
//     statusCode = json['statusCode'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }

//   Map<dynamic, dynamic> toJson() {
//     final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
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
//   dynamic? id;
//   dynamic? title;
//   dynamic? totalExpense;
//   dynamic? description;
//   List<Attachments>? attachments;
//   dynamic? status;

//   Data(
//       {this.id,
//       this.title,
//       this.totalExpense,
//       this.description,
//       this.attachments,
//       this.status});

//   Data.fromJson(Map<dynamic, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     totalExpense = json['total_expense'];
//     description = json['description'];
//     if (json['attachments'] != null) {
//       attachments = <Attachments>[];
//       json['attachments'].forEach((v) {
//         attachments!.add(new Attachments.fromJson(v));
//       });
//     }
//     status = json['status'];
//   }

//   Map<dynamic, dynamic> toJson() {
//     final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['total_expense'] = this.totalExpense;
//     data['description'] = this.description;
//     if (this.attachments != null) {
//       data['attachments'] = this.attachments!.map((v) => v.toJson()).toList();
//     }
//     data['status'] = this.status;
//     return data;
//   }
// }

// class Attachments {
//   dynamic? pathLink;

//   Attachments({this.pathLink});

//   Attachments.fromJson(Map<dynamic, dynamic> json) {
//     pathLink = json['path_link'];
//   }

//   Map<dynamic, dynamic> toJson() {
//     final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
//     data['path_link'] = this.pathLink;
//     return data;
//   }
// }

class TadaDetailResponse {
  dynamic? message;
  bool? status;
  dynamic? statusCode;
  Data? data;

  TadaDetailResponse({this.message, this.status, this.statusCode, this.data});

  TadaDetailResponse.fromJson(Map<dynamic, dynamic> json) {
    message = json['message'];
    status = json['status'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
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
  dynamic? id;
  dynamic? title;
  dynamic? totalExpense;
  dynamic? description;
  List<Attachments>? attachments;
  dynamic? status;
  dynamic? createdDate;
  dynamic? statusTitle;
  dynamic? statusChangedBy;

  Data(
      {this.id,
      this.title,
      this.totalExpense,
      this.description,
      this.attachments,
      this.status,
      this.createdDate,
      this.statusTitle,
      this.statusChangedBy});

  Data.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    title = json['title'];
    totalExpense = json['total_expense'];
    description = json['description'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(new Attachments.fromJson(v));
      });
    }
    status = json['status'];
    createdDate = json['created_date'];
    statusTitle = json['statusTitle'];
    statusChangedBy = json['statusChangedBy'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['total_expense'] = this.totalExpense;
    data['description'] = this.description;
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['created_date'] = this.createdDate;
    data['statusTitle'] = this.statusTitle;
    data['statusChangedBy'] = this.statusChangedBy;
    return data;
  }
}

class Attachments {
  dynamic? pathLink;

  Attachments({this.pathLink});

  Attachments.fromJson(Map<dynamic, dynamic> json) {
    pathLink = json['path_link'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['path_link'] = this.pathLink;
    return data;
  }
}
