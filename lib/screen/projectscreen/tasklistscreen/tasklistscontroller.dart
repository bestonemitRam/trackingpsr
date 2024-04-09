import 'dart:convert';

import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:bmitserp/data/source/network/model/tasklistresponse/tasklistresponse.dart';
import 'package:bmitserp/model/task.dart';
import 'package:bmitserp/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TaskListController extends GetxController {
  final taskList = <Task>[].obs;
  final filteredList = <Task>[].obs;
  final selected = "All".obs;

  void filterList() {
    filteredList.clear();
    if (selected.value == "All") {
      filteredList.addAll(taskList);
    } else {
      for (var project in taskList) {
        if (project.status == selected.value) {
          filteredList.add(project);
        }
      }
    }
  }

  Future<String> getTaskList() async {
    var uri = Uri.parse(Constant.TASK_LIST_URL);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      EasyLoading.show(status: "Loading", maskType: EasyLoadingMaskType.black);
      final response = await http.get(
        uri,
        headers: headers,
      );
     
      EasyLoading.dismiss(animation: true);

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        taskList.clear();
        final taskResponse = tasklistresponse.fromJson(responseData);

        for (var task in taskResponse.data) {
          taskList.add(Task(task.task_id, task.task_name, task.project_name,
              task.start_date, task.end_date, task.status));
        }

        filterList();
        return "loaded";
      } else {
        var errorMessage = responseData['message'];
      
        throw errorMessage;
      }
    } catch (e) {
    
      throw e;
    }
  }

  @override
  void onInit() {
    getTaskList();
    super.onInit();
  }
}
