import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../data/source/datastore/preferences.dart';

class Constant {

  static const production = "https://bsoe.meestdrive.in/";


  static const MAIN_URL = production;
  static const API_URL = MAIN_URL + "api";
  static const PRIVACY_POLICY_URL = MAIN_URL + "privacy";
  static const LOGIN_URL = "$API_URL/login";
  static const LOGOUT_URL = "$API_URL/logout";
  static const DASHBOARD_URL = "$API_URL/dashboard";
  //static const CHECK_IN_URL = "$API_URL/employees/check-in";
  static const CHECK_OUT_URL = "$API_URL/employees/check-out";
  static const ATTENDANCE_REPORT_URL = "$API_URL/employees/attendance-detail";
  static const LEAVE_TYPE_URL = "$API_URL/leave-types";
  static const LEAVE_TYPE_DETAIL_URL =
      "$API_URL/leave-requests/employee-leave-requests";
  static const ISSUE_LEAVE = "$API_URL/leave-requests/store";
  static const CANCEL_LEAVE = "$API_URL/leave-requests/cancel";
  static const PROFILE_URL = "$API_URL/users/profile";
  static const EMPLOYEE_PROFILE_URL = "$API_URL/users/profile-detail";
  static const CONTENT_URL = "$API_URL/static-page-content";
  static const TEAM_SHEET_URL = "$API_URL/users/company/team-sheet";
  static const LEAVE_CALENDAR_API =
      "$API_URL/leave-requests/employee-leave-calendar";
  static const LEAVE_CALENDAR_BY_DAY_API =
      "$API_URL/leave-requests/employee-leave-list";
  static const HOLIDAYS_API = "$API_URL/holidays";
  static const CHANGE_PASSWORD_API = "$API_URL/users/change-password";
  static const RULES_API = "$API_URL/company-rules";
  static const EDIT_PROFILE_URL = "$API_URL/users/update-profile";
  static const NOTIFICATION_URL = "$API_URL/notifications";
  static const NOTICE_URL = "$API_URL/notices";
  static const MEETING_URL = "$API_URL/team-meetings";

  static const PROJECT_DASHBOARD_URL = "$API_URL/project-management-dashboard";
  static const PROJECT_LIST_URL = "$API_URL/assigned-projects-list";
  static const PROJECT_DETAIL_URL = "$API_URL/assigned-projects-detail";
  static const TASK_LIST_URL = "$API_URL/assigned-task-list";
  static const TASK_DETAIL_URL = "$API_URL/assigned-task-detail";
  static const UPDATE_CHECKLIST_TOGGLE_URL =
      "$API_URL/assigned-task-checklist/toggle-status";
  static const UPDATE_TASK_TOGGLE_URL =
      "$API_URL/assigned-task-detail/change-status";
  static const EMPLOYExE_DETAIL_URL = "$API_URL/users/profile-detail";
  static const GET_COMMENT_URL = "$API_URL/assigned-task-comments";
  static const SAVE_COMMENT_URL = "$API_URL/assigned-task/comments/store";
  static const DELETE_COMMENT_URL = "$API_URL/assigned-task/comment/delete";
  static const DELETE_REPLY_URL = "$API_URL/assigned-task/reply/delete";

  static const TADA_DETAIL_URL = "$API_URL/employee/tada-details";
  static const TADA_STORE_URL = "$API_URL/employee/tada/store";
  static const TADA_UPDATE_URL = "$API_URL/employee/tada/update";
  static const TADA_DELETE_ATTACHMENT_URL =
      "$API_URL/employee/tada/delete-attachment";

  static const SUPPORT_URL = "$API_URL/support/query-store";
  static const DEPARTMENT_LIST_URL = "$API_URL/support/department-lists";
  static const SUPPORT_LIST_URL = "$API_URL/support/get-user-query-lists";
  static const TOTAL_WORKING_HOUR = 8;
}

extension StringExtension on String {
  bool isUnique() {
    return true;
  }
}

void showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 12);
}

Future<dynamic> checkInApi({
  required String userId,
  required String attendanceDate,
  required String checkInTime,
  required String latitude,
  required String longitude,
}) async {
  Preferences preferences = Preferences();
  String token = await preferences.getToken();
  var headers = {
    'user_id': userId,
    'user_token':
        '7pehy1AKqz9DEGbot17Ng5SqWsQIKPBmGuo1bjVlu1rXCCvBK6kU6ICU9Wjw4uwErX',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };
  var request = http.Request(
      'POST', Uri.parse('https://hrms.meestdrive.in/api/employees/check-in'));
  request.body = json.encode({
    "attendance_date": attendanceDate,
    "check_in_at": checkInTime,
    "check_in_latitude": latitude,
    "check_in_longitude": longitude
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
   
  } else {
  
  }
}
