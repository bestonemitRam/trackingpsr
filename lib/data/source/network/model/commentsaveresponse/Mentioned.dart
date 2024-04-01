class Mentioned {
    String id;
    String name;
    String username;

    Mentioned({required this.id,required this.name,required this.username});

    factory Mentioned.fromJson(Map<String, dynamic> json) {
        return Mentioned(
            id: json['id'], 
            name: json['name'], 
            username: json['username'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['name'] = this.name;
        data['username'] = this.username;
        return data;
    }
}