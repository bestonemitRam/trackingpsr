import 'package:bmitserp/provider/leavecalendarprovider.dart';
import 'package:bmitserp/widget/leavecalendar/LeaveCalendarView.dart';
import 'package:bmitserp/widget/leavecalendar/LeaveListview.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LeaveCalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LeaveCalendarProvider(),
      child: LeaveCalendar(),
    );
  }
}

class LeaveCalendar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LeaveCalendarState();
}

class LeaveCalendarState extends State<LeaveCalendar> {
  var initial = true;

  @override
  void didChangeDependencies() {
    if (initial) {
      getLeaves();
      getLeaveByDate();
      initial = false;
    }
    super.didChangeDependencies();
  }

  void getLeaves() async {
    await Provider.of<LeaveCalendarProvider>(context).getLeaves();
  }

  void getLeaveByDate() async {
    var inputDate = DateTime.now();
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(inputDate);
    await Provider.of<LeaveCalendarProvider>(context)
        .getLeavesByDay(outputDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Leave Calendar'),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LeaveCalendarView(),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Text(
                    'Leave List',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
              LeaveListView(),
            ],
          ),
        ),
      ),
    );
  }
}
