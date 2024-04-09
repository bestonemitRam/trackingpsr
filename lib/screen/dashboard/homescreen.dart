import 'dart:async';
import 'dart:io';

import 'package:bmitserp/data/source/network/model/login/User.dart';
import 'package:bmitserp/provider/dashboardprovider.dart';
import 'package:bmitserp/provider/prefprovider.dart';
import 'package:bmitserp/utils/constant.dart';
import 'package:bmitserp/utils/locationstatus.dart';
import 'package:bmitserp/widget/homescreen/checkattendance.dart';
import 'package:bmitserp/widget/homescreen/overviewdashboard.dart';
import 'package:bmitserp/widget/homescreen/weeklyreportchart.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:bmitserp/widget/headerprofile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  //late DashboardProvider dashboardResponse;
  void initState() {
    super.initState();

    // initializeService();
    //dashboardResponse = Provider.of<DashboardProvider>(context, listen: false);
  }

  void _startBackgroundLocationUpdates() {
    Geolocator.requestPermission().then((locationPermission) {
      if (locationPermission == LocationPermission.always) {
        Geolocator.getPositionStream().listen((Position position) {
       
          // Handle position updates
        });
      }
    });
  }
  //
  // Future<void> initializeService() async {
  //   final service = FlutterBackgroundService();
  //   await service.configure(
  //     androidConfiguration: AndroidConfiguration(
  //       // this will executed when app is in foreground or background in separated isolate
  //       onStart: onStart,
  //
  //       // auto start service
  //       autoStart: true,
  //       isForegroundMode: true,
  //     ),
  //     iosConfiguration: IosConfiguration(
  //       // auto start service
  //       autoStart: true,
  //
  //       // this will executed when app is in foreground in separated isolate
  //       onForeground: onStart,
  //       onBackground:
  //       onStart ,
  //
  //       // you have to enable background fetch capability on xcode project
  //       // onBackground: onIosBackground,
  //     ),
  //   );
  // }

  //
  // void onStart() {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   final service = FlutterBackgroundService();
  //   service.onDataReceived.listen((event) {
  //     if (event!["action"] == "setAsForeground") {
  //       service.setForegroundMode(true);
  //       return;
  //     }
  //
  //     if (event["action"] == "setAsBackground")
  //     {
  //       service.setForegroundMode(false);
  //     }
  //
  //     if (event["action"] == "stopService") {
  //       service.stopBackgroundService();
  //     }
  //   });
  //
  //   // bring to foreground
  //   service.setForegroundMode(true);
  //   Timer.periodic(Duration(seconds: 1), (timer) async
  //   {
  //     if (!(await service.isServiceRunning())) timer.cancel();
  //     service.setNotificationInfo(
  //       title: "My App Service",
  //       content: "Updated at ${DateTime.now()}",
  //     );
  //
  //     service.sendData(
  //       {"current_date": DateTime.now().toIso8601String()},
  //     );
  //   });
  // }

  void didChangeDependencies() {
    loadDashboard();
    // locationStatus();
    super.didChangeDependencies();
  }

  void locationStatus() async {
    try {
      final position = await LocationStatus().determinePosition();

      if (!mounted) {
        return;
      }
      final location =
          Provider.of<DashboardProvider>(context, listen: false).locationStatus;
      location.update('latitude', (value) => position.latitude);
      location.update('longitude', (value) => position.longitude);
    } catch (e) {
    
      showToast(e.toString());
    }
  }

  Future<String> loadDashboard() async {
    //var fcm = await FirebaseMessaging.instance.getToken();
  
    try {
      final dashboardProvider =
          await Provider.of<DashboardProvider>(context, listen: false)
              .getDashboardData();

      return 'loaded';
    } catch (e) {
   
      return 'loaded';
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => showExitPopup(context),
        child: Container(
          decoration: RadialDecoration(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              color: Colors.white,
              backgroundColor: Colors.blueGrey,
              edgeOffset: 50,
              onRefresh: () {
                return loadDashboard();
              },
              child: SafeArea(
                  child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      HeaderProfile(),
                      CheckAttendance(),
                      OverviewDashboard(),
                      // WeeklyReportChart()
                    ],
                  ),
                ),
              )),
            ),
          ),
        ));
  }

  Future<bool> showExitPopup(context) async {
   
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "If you closed app then you check out form the device",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            exit(0);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.tealAccent),
                          child: Text(
                            "Yes",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: Text("No", style: TextStyle(fontSize: 16.sp)),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
