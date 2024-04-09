import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/model/my_task.dart';
import 'package:bmitserp/utils/service.dart';
import 'package:flutter/material.dart';

class MyTaskProvider extends ChangeNotifier {
  MyTask mytaskModel = MyTask();
  List<TaskListPending> allData = [];
  List<TaskListPending> get taskListtData => allData;
  List<TaskListPending> allDataCompleted = [];
  List<TaskListPending> get allDataCompletedlist => allDataCompleted;
  bool datanotfound = false;

  Future getMyTask() async {
    allData = [];
    var url = APIURL.GET_ALL_TASK;

    ServiceWithHeader service = ServiceWithHeader(url);
    final response = await service.data();

  

    mytaskModel = MyTask.fromJson(response);
    allData = [];

    if (mytaskModel.data != null) {
      if (mytaskModel.data != null) {
        if (mytaskModel.data!.taskListPending!.isNotEmpty) {
          for (int i = 0; i < mytaskModel.data!.taskListPending!.length; i++) {
            allData.add(mytaskModel.data!.taskListPending![i]);
          }
        }
        if (mytaskModel.data!.taskListCompleted!.isNotEmpty) {
          for (int i = 0;
              i < mytaskModel.data!.taskListCompleted!.length;
              i++) {
            allDataCompleted.add(mytaskModel.data!.taskListCompleted![i]);
          }
        }
      }
    }
    datanotfound = true;
    notifyListeners();
    return;
  }
}
