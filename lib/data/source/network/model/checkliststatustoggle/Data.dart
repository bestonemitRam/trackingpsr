class Data {
    int checklist_id;
    bool is_completed;
    String name;

    Data({required this.checklist_id,required this.is_completed,required this.name});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            checklist_id: json['checklist_id'], 
            is_completed: json['is_completed'], 
            name: json['name'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['checklist_id'] = this.checklist_id;
        data['is_completed'] = this.is_completed;
        data['name'] = this.name;
        return data;
    }
}