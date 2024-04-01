class AssignedTaskDetail {
  String deadline;
  String priority;
  String start_date;
  String status;
  int task_id;
  String task_name;
  int task_progress_percent;

  AssignedTaskDetail(
      {required this.deadline,
      required this.priority,
      required this.start_date,
      required this.status,
      required this.task_id,
      required this.task_name,
      required this.task_progress_percent});

  factory AssignedTaskDetail.fromJson(Map<String, dynamic> json) {
    return AssignedTaskDetail(
      deadline: json['deadline'],
      priority: json['priority'],
      start_date: json['start_date'],
      status: json['status'],
      task_id: json['task_id'],
      task_name: json['task_name'],
      task_progress_percent: json['task_progress_percent'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deadline'] = this.deadline;
    data['priority'] = this.priority;
    data['start_date'] = this.start_date;
    data['status'] = this.status;
    data['task_id'] = this.task_id;
    data['task_name'] = this.task_name;
    data['task_progress_percent'] = this.task_progress_percent;
    return data;
  }
}
