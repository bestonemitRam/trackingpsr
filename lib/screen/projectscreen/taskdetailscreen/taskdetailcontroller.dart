import 'dart:convert';
import 'dart:io';

import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:bmitserp/data/source/network/model/checkliststatustoggle/CheckListStatusToggleResponse.dart';
import 'package:bmitserp/data/source/network/model/taskdetail/taskdetail.dart';
import 'package:bmitserp/model/checklist.dart';
import 'package:bmitserp/model/member.dart';
import 'package:bmitserp/model/task.dart';
import 'package:bmitserp/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/attachment.dart';

class TaskDetailController extends GetxController {
  var taskDetail =
      (Task.all(0, "", "", "", "", "", "", "", 0, 0, false, [], [], [])).obs;

  var memberImages = [].obs;
  var leaderImages = [].obs;

  Future<TaskDetailResponse> getTaskOverview() async {
    var uri = Uri.parse(
        Constant.TASK_DETAIL_URL + "/" + Get.arguments["id"].toString());

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
        final taskResponse = TaskDetailResponse.fromJson(responseData);

        List<Member> members = [];
        memberImages.clear();
        for (var member in taskResponse.data.assigned_member) {
          members.add(
              Member(member.id, member.name, member.avatar, post: member.post));
          memberImages.add(member.avatar);
        }

        List<Checklist> checkLists = [];
        for (var checkList in taskResponse.data.checklists) {
          checkLists.add(Checklist(checkList.id, checkList.task_id,
              checkList.name, checkList.is_completed));
        }

        List<Attachment> attachments = [];
        for (var attachment in taskResponse.data.attachments) {
          if (attachment.type == "image") {
            attachments.add(Attachment(0, attachment.attachment_url, "image"));
          } else {
            attachments.add(Attachment(0, attachment.attachment_url, "file"));
          }
        }

        var task = Task.all(
            taskResponse.data.task_id,
            taskResponse.data.task_name,
            taskResponse.data.project_name,
            taskResponse.data.description,
            taskResponse.data.start_date,
            taskResponse.data.deadline,
            taskResponse.data.priority,
            taskResponse.data.status,
            taskResponse.data.task_progress_percent,
            taskResponse.data.task_comments.length,
            taskResponse.data.has_checklist,
            members,
            checkLists,
            attachments);

        taskDetail.value = task;
        return taskResponse;
      } else {
        var errorMessage = responseData['message'];
       
        throw errorMessage;
      }
    } catch (e) {
     
      throw e;
    }
  }

  Future<bool> checkListToggle(String checkListId) async {
    var uri =
        Uri.parse(Constant.UPDATE_CHECKLIST_TOGGLE_URL + "/" + checkListId);

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
        final taskResponse =
            CheckListStatusToggleResponse.fromJson(responseData);

        return true;
      } else {
        var errorMessage = responseData['message'];
      
        return false;
      }
    } catch (e) {
    
      return false;
    }
  }

  Future<bool> checkListTaskToggle(String taskId) async {
    var uri = Uri.parse(Constant.UPDATE_TASK_TOGGLE_URL + "/" + taskId);

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
        Get.back();
        showToast("Task completed");
        return true;
      } else {
        var errorMessage = responseData['message'];
      
        return false;
      }
    } catch (e) {
   
      return false;
    }
  }

  Future<void> launchUrls(String _url) async {
    if (!await launchUrl(Uri.parse(_url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  void onInit() {
    getTaskOverview();
    super.onInit();
  }
}
