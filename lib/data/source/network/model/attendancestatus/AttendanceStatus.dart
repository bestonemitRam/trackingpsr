class AttendanceStatus {
  AttendanceStatus({
      required this.checkInAt,
      required this.checkOutAt,
      required this.productiveTimeInMin,});

  factory AttendanceStatus.fromJson(dynamic json) {
    return AttendanceStatus(
        checkInAt : json['check_in_at'].toString() ?? "-",
        checkOutAt : json['check_out_at'].toString() ?? "-",
        productiveTimeInMin : json['productive_time_in_min'] ?? 0
    );
  }


  dynamic checkInAt;
  dynamic checkOutAt;
  dynamic productiveTimeInMin;

  Map<String, dynamic>? toJson() 
  {
    final map = <String, dynamic>{};
    map['check_in_at'] = checkInAt;
    map['check_out_at'] = checkOutAt;
    map['productive_time_in_min'] = productiveTimeInMin;
    return map;
  }

}


// {
// "message": "Checked in successfully",
// "status": true,
// "statusCode": 200,
// "data": {
// "check_in_at": "10:00:00",
// "check_out_at": "-",
// "productive_time_in_min": 51
// }
// }