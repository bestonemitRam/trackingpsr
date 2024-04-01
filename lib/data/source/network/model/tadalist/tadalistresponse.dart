// import '../tadalist/Data.dart';

// class TadaListResponse {
//   List<Data> data;
//   dynamic message;
//   bool status;
//   dynamic statusCode;

//   TadaListResponse(
//       {required this.data,
//       required this.message,
//       required this.status,
//       required this.statusCode});

//   factory TadaListResponse.fromJson(Map<dynamic, dynamic> json) {
//     return TadaListResponse(
//       data: (json['data'] as List).map((i) => Data.fromJson(i)).toList(),
//       message: json['message'],
//       status: json['status'],
//       statusCode: json['statusCode'],
//     );
//   }

//   Map<dynamic, dynamic> toJson() {
//     final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
//     data['message'] = this.message;
//     data['status'] = this.status;
//     data['statusCode'] = this.statusCode;
//     if (this.data != null) {
//       data['data'] = this.data.map((v) => v.toJson()).toList();
//     //  data['data1'] =  this.data.map(v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class TadaListResponse {
//   dynamic? message;
//   bool? status;
//   dynamic? statusCode;
//   List<Data>? data;

//   TadaListResponse({this.message, this.status, this.statusCode, this.data});

//   TadaListResponse.fromJson(Map<dynamic, dynamic> json) {
//     message = json['message'];
//     status = json['status'];
//     statusCode = json['statusCode'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }

//   Map<dynamic, dynamic> toJson() {
//     final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
//     data['message'] = this.message;
//     data['status'] = this.status;
//     data['statusCode'] = this.statusCode;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
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

class TadaListResponse {
  dynamic? message;
  bool? status;
  dynamic? statusCode;
  Data? data;

  TadaListResponse({this.message, this.status, this.statusCode, this.data});

  TadaListResponse.fromJson(Map<dynamic, dynamic> json) {
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
  List<TadaList>? tadaList;

  Data({this.tadaList});

  Data.fromJson(Map<dynamic, dynamic> json) {
    if (json['tadaList'] != null) {
      tadaList = <TadaList>[];
      json['tadaList'].forEach((v) {
        tadaList!.add(new TadaList.fromJson(v));
      });
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    if (this.tadaList != null) {
      data['tadaList'] = this.tadaList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TadaList {
  dynamic? id;
  dynamic? title;
  dynamic? totalExpense;
  dynamic? description;
  dynamic? status;
  List<Attachments>? attachments;

  TadaList(
      {this.id,
      this.title,
      this.totalExpense,
      this.description,
      this.status,
      this.attachments});

  TadaList.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    title = json['title'];
    totalExpense = json['total_expense'];
    description = json['description'];
    status = json['status'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(new Attachments.fromJson(v));
      });
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['total_expense'] = this.totalExpense;
    data['description'] = this.description;
    data['status'] = this.status;
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    }
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
