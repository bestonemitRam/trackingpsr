import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:bmitserp/data/source/network/model/attendancestatus/AttendanceStatusResponse.dart';
import 'package:bmitserp/data/source/network/model/attendancestatus/checkoutmodel.dart';
import 'package:bmitserp/main.dart';

import 'package:bmitserp/model/home_page_model.dart';
import 'package:bmitserp/service/LocationService.dart';

import 'package:bmitserp/utils/constant.dart';
import 'package:bmitserp/utils/locationstatus.dart';
import 'package:bmitserp/utils/wifiinfo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import '../utils/trackModel.dart';

class DashboardProvider with ChangeNotifier {
  Timer? _timer;
  final Map<String, String> _overviewList = {
    'present': '0',
    'holiday': '0',
    'leave': '0',
    'request': '0',
    'total_project': '0',
    'total_task': '0',
  };

  final Map<String, double> locationStatus = {
    'latitude': 0.0,
    'longitude': 0.0,
  };

  Map<String, String> get overviewList {
    return _overviewList;
  }

  final Map<String, dynamic> _attendanceList = {
    'check-in': '',
    'check-out': '',
    'production_hour': '0 hr 0 min',
    'production-time': 0.0
  };
  Map<String, dynamic> get attendanceList {
    return _attendanceList;
  }

  final List<int> _weeklyReport = [];
  List<int> get weeklyReport {
    return _weeklyReport;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  List<BarChartGroupData> barchartValue = [];
  List<BarChartGroupData> rawBarGroups = [];
  List<BarChartGroupData> showingBarGroups = [];

  void buildgraph() {
    const int daysInWeek = 7;
    for (int i = 0; i < daysInWeek; i++) {
      barchartValue.add(makeGroupData(i, 0));
    }
    rawBarGroups.addAll(barchartValue);
    showingBarGroups.addAll(rawBarGroups);
  }

  Future<HomeScreenModel> getDashboardData() async {
    var uri = Uri.parse(APIURL.HOME_PAGE_URL);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();

    var fcm = await FirebaseMessaging.instance.getToken();

    int getUserID = await preferences.getUserId();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };

    try {
      final response = await http.get(uri, headers: headers);

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final dashboardResponse = HomeScreenModel.fromJson(responseData);

        updateOverView(dashboardResponse.data!);
        //print("ldkfjghfg ${dashboardResponse.data!.punchData!}");

        if (dashboardResponse.data!.punchData != null) {
          updateAttendanceStatus(dashboardResponse.data!.punchData!);
        }

        // makeWeeklyReport(dashboardResponse.data.employeeAttendanceData!);
        // DateTime startTime = DateFormat("hh:mm a")
        //     .parse(dashboardResponse.data!.officeData!.openingTime);
        // DateTime endTime = DateFormat("hh:mm a")
        //     .parse(dashboardResponse.data!.officeData!.closingTime);
        // await AwesomeNotifications().cancelAllSchedules();
        // for (var shift in dashboardResponse.data.shift_dates)
        //  {
        //   scheduleNewNotification(shift, "Please check in on time ⏱️⌛️",  startTime.hour, startTime.minute);
        //   scheduleNewNotification(
        //       shift,
        //       "Almost done with your shift 😄⌛️ Remember to checkout ⏱️",
        //       endTime.hour,
        //       endTime.minute);
        // }
        return dashboardResponse;
      } else {
        var errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (e) {
      throw e;
    }
  }

  void makeWeeklyReport(List<dynamic> employeeWeeklyReport) {
    _weeklyReport.clear();
    for (var item in employeeWeeklyReport) {
      if (item != null) {
        int hr = (item['productive_time_in_min'] / 60).toInt();
        if (hr > Constant.TOTAL_WORKING_HOUR) {
          _weeklyReport.add(Constant.TOTAL_WORKING_HOUR);
        } else {
          _weeklyReport.add(hr);
        }
      } else {
        _weeklyReport.add(0);
      }
    }

    barchartValue.clear();
    rawBarGroups.clear();
    showingBarGroups.clear();
    for (int i = 0; i < _weeklyReport.length; i++) {
      barchartValue.add(makeGroupData(i, _weeklyReport[i].toDouble()));
    }
    rawBarGroups.addAll(barchartValue);
    showingBarGroups.addAll(rawBarGroups);
    notifyListeners();
  }

  void updateAttendanceStatus(EmployeeAttendanceData employeeTodayAttendance) {
    List<String> parts = employeeTodayAttendance.punchInTime!.split(' ');
    List<String> partdata = employeeTodayAttendance.punchOutTime!.split(' ');

    _attendanceList.update(
        'production-time',
        (value) =>
            calculateProdHour(employeeTodayAttendance.totalWorkingHours!));

    _attendanceList.update('check-out', (value) => partdata[1]);

    _attendanceList.update(
        'production_hour',
        (value) => CalculateTotalWorkingHour(
            employeeTodayAttendance.totalWorkingHours!));
    _attendanceList.update('check-in', (value) => parts[1].toString()!);

    notifyListeners();
  }

  void updateOverView(HomeData overview) {
    _overviewList.update(
        'present', (value) => overview.presentCount.toString());

    _overviewList.update(
        'holiday', (value) => overview.holidayCount.toString());
    _overviewList.update('leave', (value) => overview.leaveCount.toString());
    _overviewList.update('request', (value) => overview.leaveCount.toString());
    _overviewList.update(
        'total_project', (value) => overview.leaveCount.toString());
    _overviewList.update(
        'total_task', (value) => overview.taskCount.toString());
    notifyListeners();
  }

  String CalculateTotalWorkingHour(String totalWorkingHours) {
    List<String> parts = totalWorkingHours.split(':');

    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);
    String formattedTime = '$hours h $minutes m $seconds s';

    return formattedTime;
  }

  double calculateProdHour(String value) {
    List<String> parts = value.split(':');

    // Extract hours, minutes, and seconds
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);

    // Calculate total minutes
    int totalMinutes = hours * 60 + minutes + (seconds > 30 ? 1 : 0);

    double hour = totalMinutes / 60;
    double hr = hour / Constant.TOTAL_WORKING_HOUR;
    return hr > 1 ? 1 : hr;
  }

  String calculateHourText(double value) {
    double second = value * 60.toDouble();
    double min = second / 60;
    int minGone = (min % 60).toInt();
    int hour = min ~/ 60;

    return "$hour hr $minGone min";
  }

  Future<bool> getCheckInStatus() async {
    try {
      final position = await LocationStatus().determinePosition();
      locationStatus.update('latitude', (value) => position.latitude);
      locationStatus.update('longitude', (value) => position.longitude);
      if (locationStatus['latitude'] != 0.0 &&
          locationStatus['longitude'] != 0.0) {
        return true;
      } else {
        Future.error(
            'Location is not detected. Please check if location is enabled and try again.');
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  ///MARK: - CHECK-IN API IMPLEMENTATION
  Future<AttendanceStatusResponse> checkInAttendance() async {
    final service = FlutterBackgroundService();
    var isRunning = await service.isRunning();
    print("dhjfgjdfgjjdfgh  ${isRunning}");

    service.startService();

    var uri = Uri.parse(APIURL.CHECK_IN_URL);
    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
    var fcm = await FirebaseMessaging.instance.getToken();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };
    //  LocationService.startBackgroundLocation(token, getUserID);

    Map<String, dynamic> body = {
      'punch_in_latitude': locationStatus['latitude'].toString(),
      'punch_in_longitude': locationStatus['longitude'].toString(),
    };

    try {
      final response = await http.post(uri, headers: headers, body: body);
      final responseData = json.decode(response.body);

      final attendanceResponse =
          AttendanceStatusResponse.fromJson(responseData);

      if (responseData['status'] == true) {
        // LocationService.startBackgroundLocation(token, getUserID);
        // bgLocationTask();

        final service = FlutterBackgroundService();

        var isRunning = await service.isRunning();
        if (isRunning) {
          service.invoke('stopService');
        }
        service.startService();

        // updateAttendanceStatus(EmployeeAttendanceData(
        //     punchInTime: attendanceResponse.data!.attendanceData!.punchInTime!,
        //     punchOutTime:
        //         attendanceResponse.data!.attendanceData!.punchOutTime ??
        //             "0000-00-00 00:00:00",
        //     totalWorkingHours: "00:00:00"));

        // updateAttendanceStatus(EmployeeAttendanceData(
        //     punchInTime: attendanceResponse.data!.attendanceData!.punchInTime!,
        //     punchOutTime: "0000-00-00 00:00:00",
        //     totalWorkingHours: "00:00:00"));

        return attendanceResponse;
      } else {
        //  _timer =  Timer.periodic(Duration(seconds:10), (Timer timer)
        //  {
        //    getCurrentPosition();
        //     checkOutAttendance();
        //    });

        var errorMessage = responseData['message'];
        return attendanceResponse;
      }
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> bgLocationTask() async {
  //   // BackgroundLocation.startLocationService();
  //   //initBackgroundLocation();

  //   final service = FlutterBackgroundService();

  //   var isRunning = await service.isRunning();
  //   if (isRunning) {
  //     service.invoke('stopService');
  //   }
  //   service.startService();
  //   // FlutterBackgroundService().invoke("setAsBackground");
  //   FlutterBackgroundService().invoke("setAsForeground");

  //   // // print("kfjglkfghlkfghj  ${isRunning}");
  //   // if (isRunning)
  //   // {
  //   //   service.invoke("stopService");
  //   // } else {

  //   // }

  //   // try {
  //   //   final backgroundApiViewModel = DashboardProvider();

  //   //   Timer.periodic(Duration(minutes: 1), (Timer t) async {
  //   //     print("Calling getCurrentPosition within Timer  ${DateTime.now()}");

  //   //     backgroundApiViewModel.getCurrentPosition();
  //   //   });
  //   // } catch (err, stackTrace) {
  //   //   print("This is the error: $err");
  //   //   print("Stacktrace : ${stackTrace}");
  //   //   throw Exception(err.toString());
  //   // }
  // }

  // void stopLocationService() {
  //   print("stop service");
  //   BackgroundLocation.stopLocationService();
  //   BackgroundLocation.stopLocationService();
  // }

  // void initBackgroundLocation() {
  //   print("djfgjghkj");
  //   BackgroundLocation.startLocationService(distanceFilter: 1);
  //   BackgroundLocation.isServiceRunning();
  //   BackgroundLocation.getLocationUpdates((location) async {
  //     getCurrentPosition();
  //     await dbHelper.insertLocationData(location.latitude!, location.longitude!,
  //         DateTime.now().millisecondsSinceEpoch);
  //   });
  //   BackgroundLocation().getCurrentLocation().then((location) async {
  //     print('This is current Location ' + location.toMap().toString());
  //     await dbHelper.insertLocationData(location.latitude!, location.longitude!,
  //         DateTime.now().millisecondsSinceEpoch);
  //   });
  // }

  Future<void> scheduleNewNotification(
      String date, String message, int hour, int minute) async {
    final convertedDate = new DateFormat('yyyy-MM-dd').parse(date);

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: Random().nextInt(1000000),
            // -1 is replaced by a random number
            channelKey: 'digital_hr_channel',
            title: "Hello There",
            body: message,
            //'asset://assets/images/balloons-in-sky.jpg',
            notificationLayout: NotificationLayout.Default,
            payload: {'notificationId': '1234567890'}),
        actionButtons: [
          NotificationActionButton(
              key: 'REDIRECT', label: 'Open', actionType: ActionType.Default),
          NotificationActionButton(
              key: 'DISMISS',
              label: 'Dismiss',
              actionType: ActionType.DismissAction,
              isDangerousOption: true)
        ],
        schedule: NotificationCalendar.fromDate(
            date: DateTime(convertedDate.year, convertedDate.month,
                convertedDate.day, hour, minute - 15)));
  }

  checklocation(double long, double lat) async {
    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };

    var uri = await Uri.parse(APIURL.LOCATION_TRACKER);
    try {
      final response = await http.post(uri, headers: headers, body: {
        "user_latitude": lat.toString(),
        "user_longitude": long.toString()
      });

      final responseData = json.encode(response.body);
    } catch (e) {}
  }

  Future<void> getCurrentPosition() async {
    try {
      bool result = await InternetConnectionChecker().hasConnection;

      if (result == true) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        checklocation(position.longitude, position.latitude);

        await dbHelper.insertLocationData(position.latitude!,
            position.longitude!, DateTime.now().millisecondsSinceEpoch);
      } else {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        //rampr
        // await dbHelper.insertLocationData(position.latitude!,
        //     position.longitude!, DateTime.now().millisecondsSinceEpoch);
      }
    } catch (e, stT) {
      checklocation(0.0, 0.0);
    }
  }

  ///MARK: - CheckOut API Implementation
  Future<CheckOutModel> checkOutAttendance() async {
    var uri = Uri.parse(APIURL.CHECK_Out_URL);
    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String currentTime = DateFormat('HH:mm:ss').format(DateTime.now());

    var fcm = await FirebaseMessaging.instance.getToken();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };

    Map<String, dynamic> body = {
      'punch_out_latitude': locationStatus['latitude'].toString(),
      'punch_out_longitude': locationStatus['longitude'].toString(),
    };

    try {
      final response = await http.post(uri, headers: headers, body: body);
      debugPrint(response.body.toString());
      final responseData = json.decode(response.body);

      final attendanceResponse = CheckOutModel.fromJson(responseData);

      if (response.statusCode == 200) {
        // LocationService.stopService();
        final service = FlutterBackgroundService();

        var isRunning = await service.isRunning();
        if (isRunning) {
          service.invoke('stopService');
        }

        // stopLocationService();

        if (responseData['status'] == true) {
          updateAttendanceStatus(EmployeeAttendanceData(
              punchInTime:
                  attendanceResponse.result!.attendanceData!.punchInTime,
              punchOutTime:
                  attendanceResponse.result!.attendanceData!.punchOutTime ??
                      "0000-00-00 00:00:00",
              totalWorkingHours: attendanceResponse
                  .result!.attendanceData!.totalWorkingHours));
        }

        return attendanceResponse;
      } else {
        var errorMessage = responseData['message'];
        return attendanceResponse;
      }
    } catch (e) {
      rethrow;
    }
  }

  final Color leftBarColor = HexColor("#FFFFFF");
  final double width = 15;

  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        toY: y1,
        color: leftBarColor,
        width: width,
      ),
    ]);
  }
}
