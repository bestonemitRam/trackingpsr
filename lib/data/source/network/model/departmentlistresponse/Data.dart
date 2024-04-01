class Data {
  String dept_name;
  String id;

  Data({required this.dept_name, required this.id});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      dept_name: json['dept_name'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dept_name'] = this.dept_name;
    data['id'] = this.id;
    return data;
  }
}
