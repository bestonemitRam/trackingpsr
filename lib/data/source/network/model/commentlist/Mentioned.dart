class Mentioned{
  String id;
  String name;

  Mentioned({required this.id,required this.name});

  factory Mentioned.fromJson(Map<String, dynamic> json) {
    return Mentioned(
      id: json['id'].toString(),
      name: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}