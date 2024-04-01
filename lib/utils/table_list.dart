import 'package:flutter/material.dart';


class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> tasks = [
    Task('Task 1', TaskStatus.newTask),
    Task('Task 2', TaskStatus.open),
    Task('Task 3', TaskStatus.closed),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                filterTasks(TaskStatus.newTask);
              },
              child: Text('New Task'),
            ),
            ElevatedButton(
              onPressed: () {
                filterTasks(TaskStatus.open);
              },
              child: Text('Open'),
            ),
            ElevatedButton(
              onPressed: () {
                filterTasks(TaskStatus.closed);
              },
              child: Text('Closed'),
            ),
            ElevatedButton(
              onPressed: () {
                filterTasks(TaskStatus.all);
              },
              child: Text('All'),
            ),
          ],
        ),
        DataTable(
          columns: [
            DataColumn(label: Text('Task')),
            DataColumn(label: Text('Status')),
          ],
          rows: tasks
              .map(
                (task) => DataRow(
              cells: [
                DataCell(
                  Text(task.name),
                  onTap: () {
                    if (task.status == TaskStatus.open) {
                      // If task is open, close it when clicked
                      setState(() {
                        task.status = TaskStatus.closed;
                      });
                    }
                  },
                ),
                DataCell(Text(task.status.toString())),
              ],
            ),
          )
              .toList(),
        ),
      ],
    );
  }

  void filterTasks(TaskStatus status) {
    setState(() {
      if (status == TaskStatus.all) {
        // Show all tasks
        tasks.forEach((task) => task.visible = true);
      } else {
        // Filter tasks based on status
        tasks.forEach((task) {
          task.visible = (task.status == status);
        });
      }
    });
  }
}

class Task {
  String name;
  TaskStatus status;
  bool visible; // To control visibility based on filter

  Task(this.name, this.status) : visible = true;
}

enum TaskStatus {
  newTask,
  open,
  closed,
  all,
}
