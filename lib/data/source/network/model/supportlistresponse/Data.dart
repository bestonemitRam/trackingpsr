import 'package:bmitserp/data/source/network/model/supportlistresponse/DataX.dart';

class Data {
  List<DataX> data;

  Data({required this.data});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      data: (json['data'] as List).map((i) => DataX.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
