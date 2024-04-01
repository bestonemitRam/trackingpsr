class Progres {
  int progress_in_percent;
  int total_task_assigned;
  int total_task_completed;

  Progres(
      {required this.progress_in_percent,
      required this.total_task_assigned,
      required this.total_task_completed});

  factory Progres.fromJson(Map<String, dynamic> json) {
    return Progres(
      progress_in_percent: json['progress_in_percent'],
      total_task_assigned: json['total_task_assigned'],
      total_task_completed: json['total_task_completed'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['progress_in_percent'] = this.progress_in_percent;
    data['total_task_assigned'] = this.total_task_assigned;
    data['total_task_completed'] = this.total_task_completed;
    return data;
  }
}
