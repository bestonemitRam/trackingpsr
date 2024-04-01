import 'package:bmitserp/provider/taskprovider.dart';
import 'package:bmitserp/screen/dashboard/attendancescreen.dart';
import 'package:bmitserp/screen/dashboard/leavescreen.dart';
import 'package:bmitserp/widget/headerprofile.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:bmitserp/widget/task_status/completed_task_screen.dart';
import 'package:bmitserp/widget/task_status/pending_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AttendanceScreenHistory extends StatefulWidget {
  const AttendanceScreenHistory({super.key});

  @override
  State<AttendanceScreenHistory> createState() => _TaskStatusScreenState();
}

class _TaskStatusScreenState extends State<AttendanceScreenHistory> {
  @override
  Widget build(BuildContext context) {
    return 
    
    DefaultTabController(
      length: 2,
      child: Container(
        decoration: RadialDecoration(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 3.h,
                ),
                HeaderProfile(),
                SizedBox(
                  height: 2.h,
                ),
                SingleChildScrollView(
                
                  child: Padding(
                    padding: EdgeInsets.only(right: 2.w),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                      ),
                      child: TabBar(
                          unselectedLabelColor: Colors.redAccent,
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.transparent,
                          indicator: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.white10, Colors.white38]),
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.redAccent),
                       
                          tabs: [
                            Tab(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Leave",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                            Tab(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Attendance History',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
                Expanded(
                  child:
                      TabBarView(children: [LeaveScreen(), AttendanceScreen()]),
                )
              ],
            ),
          ),
        ),
      ),
    );
 
  }
}
