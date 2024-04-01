class MyTask {
  dynamic? message;
  bool? status;
  dynamic? statusCode;
  Data? data;

  MyTask({this.message, this.status, this.statusCode, this.data});

  MyTask.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<TaskListPending>? taskListPending;
  List<TaskListPending>? taskListCompleted;

  Data({this.taskListPending, this.taskListCompleted});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['task-list-pending'] != null) {
      taskListPending = <TaskListPending>[];
      json['task-list-pending'].forEach((v) {
        taskListPending!.add(new TaskListPending.fromJson(v));
      });
    }
    if (json['task-list-completed'] != null) {
      taskListCompleted = <TaskListPending>[];
      json['task-list-completed'].forEach((v) {
        taskListCompleted!.add(new TaskListPending.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.taskListPending != null) {
      data['task-list-pending'] =
          this.taskListPending!.map((v) => v.toJson()).toList();
    }
    if (this.taskListCompleted != null) {
      data['task-list-completed'] =
          this.taskListCompleted!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskListPending {
  dynamic? id;
  dynamic? assignedFromId;
  dynamic? taskName;
  dynamic? taskStartingDate;
  dynamic? taskEndingDate;
  dynamic? taskStatus;

  TaskListPending(
      {this.id,
      this.assignedFromId,
      this.taskName,
      this.taskStartingDate,
      this.taskEndingDate,
      this.taskStatus});

  TaskListPending.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    assignedFromId = json['assigned_from_id'];
    taskName = json['task_name'];
    taskStartingDate = json['task_starting_date'];
    taskEndingDate = json['task_ending_date'];
    taskStatus = json['task_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['assigned_from_id'] = this.assignedFromId;
    data['task_name'] = this.taskName;
    data['task_starting_date'] = this.taskStartingDate;
    data['task_ending_date'] = this.taskEndingDate;
    data['task_status'] = this.taskStatus;
    return data;
  }
}
