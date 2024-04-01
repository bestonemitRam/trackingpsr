class ProjectLeader {
    String avatar;
    int id;
    String name;

    ProjectLeader({required this.avatar,required this.id,required this.name});

    factory ProjectLeader.fromJson(Map<String, dynamic> json) {
        return ProjectLeader(
            avatar: json['avatar'], 
            id: json['id'], 
            name: json['name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['avatar'] = this.avatar;
        data['id'] = this.id;
        data['name'] = this.name;
        return data;
    }
}