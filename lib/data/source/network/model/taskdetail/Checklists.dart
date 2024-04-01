class Checklists {
    int id;
    String is_completed;
    String name;
    String task_id;

    Checklists({required this.id,required this.is_completed,required this.name,required this.task_id});

    factory Checklists.fromJson(Map<String, dynamic> json) {
        return Checklists(
            id: json['id'], 
            is_completed: json['is_completed'], 
            name: json['name'], 
            task_id: json['task_id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['is_completed'] = this.is_completed;
        data['name'] = this.name;
        data['task_id'] = this.task_id;
        return data;
    }
}