import 'package:bmitserp/provider/leavecalendarprovider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class LeaveCalendarView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LeaveCalendarState();
}

class LeaveCalendarState extends State<LeaveCalendarView> {
  var _current = DateTime.now();
  var _selected = DateTime.now();
  final currentMonth = DateTime.now().month;
  final nextMonth = DateTime.now().month + 1;

  void getLeaveByDate(DateTime value) async {
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(value);
    await Provider.of<LeaveCalendarProvider>(context, listen: false)
        .getLeavesByDay(outputDate);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LeaveCalendarProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      child: TableCalendar(
        headerStyle: const HeaderStyle(
            titleTextStyle: TextStyle(color: Colors.white),
            formatButtonTextStyle: TextStyle(
              color: Colors.transparent,
            ),
            formatButtonDecoration: BoxDecoration(color: Colors.transparent),
            leftChevronIcon: Icon(
              Icons.arrow_left,
              color: Colors.white,
            ),
            rightChevronIcon: Icon(
              Icons.arrow_right,
              color: Colors.white,
            )),
        calendarStyle: const CalendarStyle(
          defaultTextStyle: TextStyle(color: Colors.white),
          weekendTextStyle: TextStyle(color: Colors.white),
        ),
        eventLoader: (day) {
          var inputDate = day;
          var outputFormat = DateFormat('yyyy-MM-dd');
          var outputDate = outputFormat.format(inputDate);
          if (provider.employeeLeaveList.containsKey(outputDate)) {
            return provider.employeeLeaveList[outputDate] ?? [];
          } else {
            return [];
          }
        },
        currentDay: _current,
        firstDay: DateTime.utc(_current.year, currentMonth, 01),
        lastDay:
            DateTime.utc(_current.add(Duration(days: 60)).year, nextMonth, 30),
        focusedDay: _selected,
        selectedDayPredicate: (day) {
          return isSameDay(_selected, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selected = selectedDay;
            getLeaveByDate(_selected);
          });
        },
      ),
    );
  }
}
