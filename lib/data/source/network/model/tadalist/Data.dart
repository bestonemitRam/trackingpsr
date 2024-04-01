class Data {
  String employee;
  int id;
  String remark;
  String status;
  String submitted_date;
  String title;
  String total_expense;

  Data(
      {required this.employee,
      required this.id,
      required this.remark,
      required this.status,
      required this.submitted_date,
      required this.title,
      required this.total_expense});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      employee: json['employee'],
      id: json['id'],
      remark: json['remark'],
      status: json['status'],
      submitted_date: json['submitted_date'],
      title: json['title'],
      total_expense: json['total_expense'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee'] = this.employee;
    data['id'] = this.id;
    data['remark'] = this.remark;
    data['status'] = this.status;
    data['submitted_date'] = this.submitted_date;
    data['title'] = this.title;
    data['total_expense'] = this.total_expense;
    return data;
  }
}
