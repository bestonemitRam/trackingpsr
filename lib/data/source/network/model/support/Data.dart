class Data {
  String created_at;
  String created_by;
  String description;
  int id;
  String title;

  Data(
      {required this.created_at,
      required this.created_by,
      required this.description,
      required this.id,
      required this.title});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      created_at: json['created_at'],
      created_by: json['created_by'],
      description: json['description'],
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.created_at;
    data['created_by'] = this.created_by;
    data['description'] = this.description;
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
